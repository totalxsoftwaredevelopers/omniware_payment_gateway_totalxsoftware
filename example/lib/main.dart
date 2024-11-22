import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:omniware_payment_gateway_totalxsoftware/enums/currency.dart';
import 'package:omniware_payment_gateway_totalxsoftware/omniware_payment_gateway_totalxsoftware.dart';
import 'package:omniware_payment_gateway_totalxsoftware_example/firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Omniware Payment Gateway',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PaymentScreen(),
    );
  }
}

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Omniware Payment Gateway"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            OmniwarePaymentGatewayTotalxsoftware.pay(
              context,
              saveInFirebase: true,
              appName: 'omniware_payment_gateway_totalxsoftware',
              //
              paymentMode: PaymentMode.TEST,
              amount: 100,
              apiKey: 'fb6bca86-b429-4abf-a42f-824bdd29022e',
              merchantId: '291499',
              salt: '80c67bfdf027da08de88ab5ba903fecafaab8f6d',
              description:
                  'product or service', //Brief description of product or service that the customer is being charged for
              currency: Currency.INR,
              returnUrl: 'https://totalx.in',
              //
              userProfile: OmniwareUserProfile(
                uid: 'unique_user_id',
                name: 'John Doe',
                email: 'qYqgK@example.com',
                phoneNumber: '1234567890',
                city: 'Malappuram',
                state: 'Kerala',
                country: 'IND',
                zipcode: '679329',
                // addressline_1: '',
                // addressline_2: '',
              ),
              success: (response, orderId) {
                log(response.toString());
              },
              failure: (response, orderId) {
                log(response.toString());
              },
              error: (response) {
                log(response.toString());
              },
            );
          },
          child: const Text("Make Payment"),
        ),
      ),
    );
  }
}
