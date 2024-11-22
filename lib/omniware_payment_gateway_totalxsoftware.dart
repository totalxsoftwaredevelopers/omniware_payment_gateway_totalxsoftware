// ignore_for_file: use_build_context_synchronously

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

export 'package:omniware_payment_gateway_totalxsoftware/enums/payment_mode.dart';
export 'package:omniware_payment_gateway_totalxsoftware/models/omniware_user_profile_model.dart';
export 'package:omniware_payment_gateway_totalxsoftware/omniware_payment_gateway_totalxsoftware.dart';

class OmniwarePaymentGatewayTotalxsoftware {
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
    required Currency currency,
    required String returnUrl,
    required OmniwareUserProfile userProfile,
    required Function(
      Map<String, dynamic>? response,
      String orderId,
    ) success,
    required Function(
      Map<String, dynamic>? response,
      String orderId,
    ) failure,
    required Function(String response) error,
  }) async {
    try {
      if (apiKey.trim().isEmpty) {
        error.call('Api Key cannot be empty');
        return;
      }
      if (merchantId.trim().isEmpty) {
        error.call('Merchant Id cannot be empty');
        return;
      }
      if (merchantId.trim().isEmpty) {
        error.call('salt cannot be empty');
        return;
      }

      //Payment Alert
      final isAgree = await showPaymentAlert(context);

      if (!isAgree) return;

      showProgress(context);
      final orderId = generateOrderId(merchantId);
      String? docid;
      if (saveInFirebase) {
        docid = SaveFirebase.createFirebasePaymentID();
      }

      if (saveInFirebase) {
        await SaveFirebase.createProcessingTransaction(
          apiKey: apiKey,
          merchantId: merchantId,
          salt: salt,
          orderId: orderId,
          amount: amount,
          appName: appName,
          transaction: docid!,
          userProfile: userProfile,
          description: description,
        );
      }
      // Payment parameters
      Map<String, String> parameters = {
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
      // Compute hash
      final hash = generateHash(salt: salt, parameters: parameters);
      // Payment options
      Map<String, dynamic> options = {
        ...parameters,
        'hash': hash,
      };

      // Launch payment
      final response = await PaymentGatewayPlugin.open(
          'https://pgbiz.omniware.in/v2/paymentrequest', options);
      Navigator.pop(context);
      if (response != null) {
        String status = response['status'] ?? 'Unknown';

        if (status == "Success" || status == "success") {
          // Handle success
          if (saveInFirebase) {
            SaveFirebase.updateSuccessTransaction(
              transaction: docid!,
              successResponse: response,
            );
          }
          success.call(response, orderId);
        } else {
          if (saveInFirebase) {
            SaveFirebase.updateFailureTransaction(
              transaction: docid!,
              failureResponse: response,
            );
          }
          failure.call(response, orderId);
        }
      } else {
        error.call("No response received from the payment gateway.");
      }
    } on Exception catch (e) {
      error.call(e.toString());
      Navigator.pop(context);
    }
  }
}
