String generateOrderId(String merchantId) {
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  return '${merchantId}_$timestamp';
}
