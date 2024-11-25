// ignore_for_file: use_build_context_synchronously

library omniware_payment_gateway_totalxsoftware;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:omniware_payment_gateway_totalxsoftware/enums/currency.dart';
import 'package:omniware_payment_gateway_totalxsoftware/enums/payment_mode.dart';
import 'package:omniware_payment_gateway_totalxsoftware/models/omniware_user_profile_model.dart';
import 'package:omniware_payment_gateway_totalxsoftware/service/generate_hash.dart';
import 'package:omniware_payment_gateway_totalxsoftware/service/generate_order_id.dart';
import 'package:omniware_payment_gateway_totalxsoftware/service/save_firebase.dart';
import 'package:omniware_payment_gateway_totalxsoftware/widget/payment_alert.dart';
import 'package:omniware_payment_gateway_totalxsoftware/widget/show_progress.dart';
import 'package:payment_gateway_plugin/payment_gateway_plugin.dart';

export 'enums/currency.dart';
export 'enums/payment_mode.dart';
export 'models/omniware_user_profile_model.dart';
export 'service/generate_hash.dart';
export 'service/generate_order_id.dart';
export 'service/save_firebase.dart';
export 'widget/payment_alert.dart';
export 'widget/show_progress.dart';

/// Omniware Payment Gateway SDK
///
/// Provides a static method [pay] to facilitate payments using the Omniware Payment Gateway.
class OmniwarePaymentGatewayTotalxsoftware {
  /// Initiates a payment process using the Omniware Payment Gateway.
  ///
  /// Parameters:
  /// - [context]: BuildContext for showing dialogs and progress indicators.
  /// - [paymentMode]: Selected payment mode (e.g., UPI, card, etc.).
  /// - [saveInFirebase]: Save transaction in Firebase (if true).
  /// - [amount]: Payment amount (must be >= 2).
  /// - [apiKey], [merchantId], [salt]: Credentials for payment gateway.
  /// - [appName]: Application name initiating the payment.
  /// - [description]: Description of the transaction.
  /// - [returnUrl]: URL to redirect after payment.
  /// - [userProfile]: User profile information.
  /// - [success]: Callback for successful transactions.
  /// - [failure]: Callback for failed transactions.
  /// - [error]: Callback for errors during the payment process.
  static Future<void> pay(
    BuildContext context, {
    required PaymentMode paymentMode,
    required bool saveInFirebase,
    required num amount,
    required String apiKey,
    required String merchantId,
    required String salt,
    required String appName,
    required String description,
    required String returnUrl,
    required OmniwareUserProfile userProfile,
    required Function(Map<String, dynamic>? response, String orderId) success,
    required Function(Map<String, dynamic>? response, String orderId) failure,
    required Function(String response) error,
  }) async {
    try {
      // Enforce INR currency
      const currency = Currency.INR;

      // Validate parameters
      if (apiKey.trim().isEmpty) {
        error('API Key cannot be empty');
        return;
      }
      if (merchantId.trim().isEmpty) {
        error('Merchant ID cannot be empty');
        return;
      }
      if (salt.trim().isEmpty) {
        error('Salt cannot be empty');
        return;
      }
      if (amount < 2) {
        error('Amount must be at least 2');
        return;
      }

      // Show payment alert
      final isAgree = await showPaymentAlert(context);
      if (!isAgree) return;

      // Show progress
      showProgress(context);

      // Generate order ID and Firebase document ID
      final orderId = generateOrderId(merchantId);
      String? docId;
      if (saveInFirebase) {
        docId = SaveFirebase.createFirebasePaymentID();
      }

      // Save processing transaction in Firebase
      if (saveInFirebase) {
        await SaveFirebase.createProcessingTransaction(
          apiKey: apiKey,
          merchantId: merchantId,
          salt: salt,
          orderId: orderId,
          amount: amount,
          appName: appName,
          transaction: docId!,
          userProfile: userProfile,
          description: description,
        );
      }

      // Generate payment parameters
      final parameters = {
        'api_key': apiKey,
        'order_id': orderId,
        'mode': paymentMode.name,
        'description': description,
        'currency': currency.name,
        'amount': amount.toString(),
        'name': userProfile.name,
        'email': userProfile.email,
        'phone': userProfile.phoneNumber,
        'city': userProfile.city,
        'state': userProfile.state,
        'country': currency.name,
        'zip_code': userProfile.zipcode,
        if (userProfile.addressline_1 != null)
          'address_line_1': userProfile.addressline_1!,
        if (userProfile.addressline_2 != null)
          'address_line_2': userProfile.addressline_2!,
        'return_url': returnUrl,
      };

      // Generate hash
      final hash = GenerateHash().generate(salt: salt, parameters: parameters);

      // Launch payment gateway
      final response = await PaymentGatewayPlugin.open(
        'https://pgbiz.omniware.in/v2/paymentrequest',
        {...parameters, 'hash': hash},
      );

      Navigator.pop(context);

      if (response != null) {
        final status = response['status']?.toLowerCase() ?? 'unknown';
        if (status == 'success') {
          if (saveInFirebase) {
            SaveFirebase.updateSuccessTransaction(
              transaction: docId!,
              successResponse: response,
            );
          }
          success(response, orderId);
        } else {
          if (saveInFirebase) {
            SaveFirebase.updateFailureTransaction(
              transaction: docId!,
              failureResponse: response,
            );
          }
          failure(response, orderId);
        }
      } else {
        error('No response received from the payment gateway.');
      }
    } on Exception catch (e) {
      error(e.toString());
      Navigator.pop(context);
    }
  }
}
