import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:omniware_payment_gateway_totalxsoftware/models/omniware_user_profile_model.dart';

/// A class that handles saving payment transaction data to Firebase.
class SaveFirebase {
  /// The name of the collection in Firestore where payment transactions are stored.
  static const collectionName = 'omniwarePaymentTransaction';

  /// The name of the payment gateway (Omniware) used for transactions.
  static const gateway = 'omniware';

  /// Generates a new Firebase document ID for a payment transaction.
  ///
  /// This method creates a new document ID in the 'razorpayPaymentTransaction' 
  /// collection and returns it for use in creating a transaction record.
  static String createFirebasePaymentID() {
    final id = _firestore.collection('razorpayPaymentTransaction').doc().id;
    return id;
  }

  /// The instance of Firestore used to interact with the Firestore database.
  static final _firestore = FirebaseFirestore.instance;

  /// Creates a new processing payment transaction record in Firebase.
  ///
  /// This method creates a new document in the Firestore collection to track 
  /// a payment transaction that is in progress. The document includes transaction 
  /// details such as amount, merchant ID, description, and user profile.
  ///
  /// Parameters:
  /// - [amount]: The transaction amount.
  /// - [apiKey]: The API key used for the transaction.
  /// - [merchantId]: The merchant ID for the transaction.
  /// - [salt]: The salt value used in the payment process.
  /// - [appName]: The name of the application initiating the payment.
  /// - [description]: The description of the payment.
  /// - [userProfile]: The user's profile information.
  /// - [transaction]: The unique transaction ID.
  /// - [orderId]: The unique order ID for the payment.
  static Future<void> createProcessingTransaction({
    required num amount,
    required String apiKey,
    required String merchantId,
    required String salt,
    required String appName,
    required String description,
    required OmniwareUserProfile userProfile,
    required String transaction,
    required String orderId,
  }) async {
    _firestore.collection(collectionName).doc(transaction).set(
      {
        'status': 'processing',
        'gateway': gateway,
        'platform': Platform.isAndroid ? 'android' : 'ios',
        'amount': amount,
        'apiKey': apiKey,
        'merchantId': merchantId,
        'salt': salt,
        'appName': appName,
        'description': description,
        'user': userProfile.toMap(),
        'id': transaction,
        'createdAt': FieldValue.serverTimestamp(),
        'orderId': orderId,
      },
    );
  }

  /// Updates the Firestore record with the success response of a payment transaction.
  ///
  /// This method updates the payment transaction status to 'success' and adds the
  /// success response to the Firestore document.
  ///
  /// Parameters:
  /// - [transaction]: The unique transaction ID.
  /// - [successResponse]: The success response data returned from the payment gateway.
  static Future<void> updateSuccessTransaction({
    required String transaction,
    required Map<String, dynamic>? successResponse,
  }) async {
    _firestore.collection(collectionName).doc(transaction).update(
      {
        'successResponse': successResponse?['response'] != null
            ? jsonDecode(successResponse!['response'])
            : 'No response',
        'status': 'success',
        'successTime': FieldValue.serverTimestamp(),
      },
    );
  }

  /// Updates the Firestore record with the failure response of a payment transaction.
  ///
  /// This method updates the payment transaction status to 'failure' and adds the
  /// failure response to the Firestore document.
  ///
  /// Parameters:
  /// - [transaction]: The unique transaction ID.
  /// - [failureResponse]: The failure response data returned from the payment gateway.
  static Future<void> updateFailureTransaction({
    required String transaction,
    required Map<String, dynamic>? failureResponse,
  }) async {
    _firestore.collection(collectionName).doc(transaction).update(
      {
        'failureResponse': failureResponse?['response'] != null
            ? jsonDecode(failureResponse!['response'])
            : 'No response',
        'status': 'failure',
        'failureTime': FieldValue.serverTimestamp(),
      },
    );
  }
}
