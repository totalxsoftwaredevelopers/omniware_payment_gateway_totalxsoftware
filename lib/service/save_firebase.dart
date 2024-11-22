import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:omniware_payment_gateway_totalxsoftware/models/omniware_user_profile_model.dart';

class SaveFirebase {
  static const collectionName = 'omniwarePaymentTransaction';
  static const gateway = 'omniware';

  static String createFirebasePaymentID() {
    final id = _firestore.collection('razorpayPaymentTransaction').doc().id;
    return id;
  }

  static final _firestore = FirebaseFirestore.instance;
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
