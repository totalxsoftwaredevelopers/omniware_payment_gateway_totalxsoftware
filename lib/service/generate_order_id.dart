/// Generates a unique order ID based on the merchant ID and current timestamp.
///
/// [merchantId] is the unique identifier for the merchant.
/// Returns a unique order ID string.
String generateOrderId(String merchantId) {
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  return '${merchantId}_$timestamp';
}
