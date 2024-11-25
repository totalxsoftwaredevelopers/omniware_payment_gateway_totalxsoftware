import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:omniware_payment_gateway_totalxsoftware/omniware_payment_gateway_totalxsoftware.dart';
// import 'package:omniware_payment_gateway_totalxsoftware_example/firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
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
              appName: 'totalxsoftwareapp',
              //
              paymentMode: PaymentMode.LIVE, // LIVE or TEXT
              amount: 100, //
              apiKey: 'YOUR_API_KEY', // Replace with your actual API key
              merchantId:
                  'YOUR_MERCHANT_ID', // Replace with your actual Merchant ID
              salt: 'YOUR_SALT', // Replace with your actual Salt value
              description:
                  'Brief description of product or service being charged for', // Replace with your product description
              returnUrl: 'https://totalx.in', // Replace with your return URL
              //
              userProfile: OmniwareUserProfile(
                uid: 'user_unique_id', // Replace with the user's unique ID
                name: 'Customer Name', // Replace with the customer's name
                email:
                    'customer@example.com', // Replace with the customer's email
                phoneNumber:
                    '1234567890', // Replace with the customer's phone number
                city: 'City Name', // Replace with the customer's city
                state: 'State Name', // Replace with the customer's state
                country:
                    'Country Code', // Replace with the country code (e.g., IND)
                zipcode: '123456', // Replace with the customer's zip code
                // addressline_1: 'Address Line 1', // Uncomment and replace as needed
                // addressline_2: 'Address Line 2', // Uncomment and replace as needed
              ),
              success: (response, orderId) {
                log('Payment Success: $response');
                log('Order ID: $orderId');
              },
              failure: (response, orderId) {
                log('Payment Failure: $response');
                log('Order ID: $orderId');
              },
              error: (response) {
                log('Payment Error: $response');
              },
            );
          },
          child: const Text("Make Payment"),
        ),
      ),
    );
  }
}
