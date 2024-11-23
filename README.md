# Omniware Payment Gateway Totalxsoftware - Flutter Plugin

<a href="https://totalx.in">
<img alt="Launch Totalx" src="https://totalx.in/assets/logo-k3HH3X3v.png">
</a>

<p><strong>Developed by <a rel="noopener" target="_new" style="--streaming-animation-state: var(--batch-play-state-1); --animation-rate: var(--batch-play-rate-1);" href="https://totalx.in"><span style="--animation-count: 18; --streaming-animation-state: var(--batch-play-state-2);">Totalx Software</span></a></strong></p>

---

## About

The **Omniware Payment Gateway Totalxsoftware** Flutter plugin provides seamless integration with the Omniware payment gateway, enabling secure and efficient payment processing for Flutter applications.

<a href="https://omniware.in"> <img alt="Omniware" src="https://omniware.in/img/logo.svg" width="200"> </a>

## Features

- **Simple Integration**: Easily integrate Omniware payment gateway into your Flutter apps.
- **Customizable**: Supports various payment modes, currencies, and user profiles.
- **Save in Firebase**: Optionally save payment data in Firebase for easy tracking.
- **Secure Payments**: Ensures encryption and secure payment processing.




## Installation

1. Add the dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  omniware_payment_gateway_totalxsoftware: ^1.0.0
```

2. Run flutter pub get to install the package.

3. Import the plugin in your Dart file:

```dart
import 'package:omniware_payment_gateway_totalxsoftware/omniware_payment_gateway_totalxsoftware.dart';
```

---

## Platform-Specific Setup

### Android Integration

1. Update `AndroidManifest.xml`: Add the namespace for tools and update the app label:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools">
    <application
        android:label="@string/totalxsoftwareapp"
        ... >
        ...
    </application>
</manifest>

// add
<!-- ++  xmlns:tools="http://schemas.android.com/tools
++  android:label="@string/totalxsoftwareapp" -->

```

2. Add Colors in `res/values/colors.xml`:

```xml
<resources>
    <color name="colorPrimary">#FF6200EE</color>
    <color name="colorPrimaryDark">#FF3700B3</color>
    <color name="colorAccent">#FF03DAC5</color>
</resources>

```

3. Add Strings in `res/values/strings.xml`:

```xml
<resources>
    <string name="app_name">Kurikkal Business Park</string>
    <string name="totalxsoftwareapp">Kurikkal Business Park</string>
</resources>

```

4. Add Styles in `res/values/styles.xml`:

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <style name="LaunchTheme" parent="@android:style/Theme.Light.NoTitleBar">
        <item name="android:windowBackground">@drawable/launch_background</item>
    </style>

    <style name="NormalTheme" parent="@android:style/Theme.Light.NoTitleBar">
        <item name="android:windowBackground">?android:colorBackground</item>
    </style>

    <style name="AppTheme" parent="Theme.AppCompat.Light.NoActionBar">
        <item name="colorPrimary">@color/colorPrimary</item>
        <item name="colorPrimaryDark">@color/colorPrimaryDark</item>
        <item name="colorAccent">@color/colorAccent</item>
    </style>
</resources>

  // add
  <!-- ++  <style name="AppTheme" parent="Theme.AppCompat.Light.NoActionBar">
  ++      <item name="colorPrimary">@color/colorPrimary</item>
  ++      <item name="colorPrimaryDark">@color/colorPrimaryDark</item>
  ++      <item name="colorAccent">@color/colorAccent</item>
  ++  </style> -->

```

5. Update `settings.gradle`: Add your plugin:

```gradle
...
include ":app"
include ":payment_gateway_plugin"
...
```

6. Update `app/build.gradle`: Ensure necessary dependencies are included:

```gradle
dependencies {
    implementation 'androidx.appcompat:appcompat:1.6.0'
    // Other dependencies
    ...
}

```
---

## iOS Integration

1. Update `Info.plist`: Add supported UPI and payment apps:

```xml
<dict>
    ...
    <key>LSApplicationQueriesSchemes</key>
    <array>
        <string>upi</string>
        <string>credpay</string>
        <string>gpay</string>
        <string>phonepe</string>
        <string>paytmmp</string>
        <string>mobikwik</string>
        <string>com.amazon.mobile.shopping</string>
        <string>bharatpe</string>
        <string>freecharge</string>
        <string>payzapp</string>
        <string>myjio</string>
        <string>bhim</string>
        <string>slice</string>
        ...
    </array>
    ...
</dict>

```

---

## List of Request Parameters

| **Parameter Name**         | **Description**                                                                                                                                                                   | **Required**  | **Datatype**                         |
|-----------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------|---------------------------------------|
| `api_key`                  | Unique 40-digit merchant key assigned to your business/login account. Each login account will have its own `api_key`.                                                            | Mandatory     | String (Max: 40)                     |
| `order_id`                 | Merchant reference number. Must be unique for every transaction. Duplicate `order_id`s for the same merchant are not allowed.                                                    | Mandatory     | String (Max: 30)                     |
| `mode`                     | Payment mode (`TEST` or `LIVE`).                                                                                                                                                | Optional      | String (Max: 4)                      |
| `amount`                   | Payment amount.                                                                                                                                                                 | Mandatory     | Max 15 digits before decimal + Max 2 |
| `currency`                 | 3-digit currency code, e.g., `INR`.                                                                                                                                             | Mandatory     | String (Max: 3)                      |
| `description`              | Brief description of the product or service being charged.                                                                                                                      | Mandatory     | String (Max: 200)                    |
| `name`                     | Customer's name.                                                                                                                                                                | Mandatory     | String (Max: 200)                    |
| `email`                    | Customer's email address.                                                                                                                                                       | Mandatory     | String (Max: 200)                    |
| `phone`                    | Customer's phone number.                                                                                                                                                        | Mandatory     | String (Max: 30)                     |
| `address_line_1`           | Customer's address line 1.                                                                                                                                                      | Optional      | String (Max: 255)                    |
| `address_line_2`           | Customer's address line 2.                                                                                                                                                      | Optional      | String (Max: 255)                    |
| `city`                     | Customer's city.                                                                                                                                                                | Mandatory     | String (Max: 50)                     |
| `state`                    | Customer's state.                                                                                                                                                               | Optional      | String (Max: 50)                     |
| `country`                  | Customer's country.                                                                                                                                                             | Mandatory     | String (Max: 10)                     |
| `zip_code`                 | Customer's ZIP code.                                                                                                                                                            | Mandatory     | Integer (Min: 0, Max: 1000)  
| `return_url`               | URL for success - POST request will be made to this URL after a successful transaction.                                                                                         | Mandatory     | String (Max: 200)                    |

---


<p>For further details on the Omniware payment gateway integration, refer to the official <a rel="noopener" target="_new" style="--streaming-animation-state: var(--batch-play-state-1); --animation-rate: var(--batch-play-rate-1);" href="https://omniware.in/android_integration.html"><span style="--animation-count: 44; --streaming-animation-state: var(--batch-play-state-2);">Omniware</span><span style="--animation-count: 45; --streaming-animation-state: var(--batch-play-state-2);"> Integration</span><span style="--animation-count: 47; --streaming-animation-state: var(--batch-play-state-2);"> Guide</span></a>.</p>








## Example

Here’s a sample implementation in Flutter:

```dart
OmniwarePaymentGatewayTotalxsoftware.pay(
  context,
  saveInFirebase: true,
  appName: 'totalxsoftwareapp',
  //
  paymentMode: PaymentMode.LIVE, // LIVE or TEXT
  amount: 100, // Amount in the smallest currency unit (e.g., 100 = 1.00 INR)
  apiKey: 'YOUR_API_KEY', // Replace with your actual API key
  merchantId: 'YOUR_MERCHANT_ID', // Replace with your actual Merchant ID
  salt: 'YOUR_SALT', // Replace with your actual Salt value
  description:
      'Brief description of product or service being charged for', // Replace with your product description
  currency: Currency.INR, // Change currency as required
  returnUrl: 'https://totalx.in', // Replace with your return URL
  //
  userProfile: OmniwareUserProfile(
    uid: 'user_unique_id', // Replace with the user's unique ID
    name: 'Customer Name', // Replace with the customer's name
    email: 'customer@example.com', // Replace with the customer's email
    phoneNumber: '1234567890', // Replace with the customer's phone number
    city: 'City Name', // Replace with the customer's city
    state: 'State Name', // Replace with the customer's state
    country: 'Country Code', // Replace with the country code (e.g., IND)
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

```

## Explore more about TotalX at www.totalx.in - Your trusted software development company!





<div style="display: flex; gap: 20px; justify-content: center; align-items: center; margin-top: 15px;"> <a href="https://www.youtube.com/channel/UCWysKlrrg4_a3W4Usw5MYKw" target="_blank"> <img src="https://cdn-icons-png.flaticon.com/512/1384/1384060.png" alt="YouTube" width="60" height="60"> <p style="text-align: center;">YouTube</p> </a> <a href="https://x.com/i/flow/login?redirect_after_login=%2FTOTALXsoftware" target="_blank"> <img src="https://cdn-icons-png.flaticon.com/512/733/733579.png" alt="X (Twitter)" width="60" height="60"> <p style="text-align: center;">Twitter</p> </a> <a href="https://www.instagram.com/totalx.in/" target="_blank"> <img src="https://cdn-icons-png.flaticon.com/512/1384/1384063.png" alt="Instagram" width="60" height="60"> <p style="text-align: center;">Instagram</p> </a> <a href="https://www.linkedin.com/company/total-x-softwares/" target="_blank"> <img src="https://cdn-icons-png.flaticon.com/512/145/145807.png" alt="LinkedIn" width="60" height="60"> <p style="text-align: center;">LinkedIn</p> </a> </div>

## 🌐 Connect with Totalx Software

Join the vibrant Flutter Firebase Kerala community for updates, discussions, and support:

<a href="https://t.me/Flutter_Firebase_Kerala" target="_blank" style="text-decoration: none;"> <img src="https://cdn-icons-png.flaticon.com/512/2111/2111646.png" alt="Telegram" width="90" height="90"> <p><b>Flutter Firebase Kerala Totax</b></p> </a>