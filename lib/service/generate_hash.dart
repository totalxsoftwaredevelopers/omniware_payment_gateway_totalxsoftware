import 'dart:convert';

import 'package:crypto/crypto.dart';

String generateHash({
  required String salt,
  required Map<String, String> parameters,
}) {
  // Concatenate parameters in required order
  String concatenated = parameters.entries
      .map((entry) => entry.value)
      .join('|'); // Assuming '|' is the separator

  // Append SALT
  concatenated += '|$salt';

  // Compute SHA-256 hash
  var bytes = utf8.encode(concatenated);
  var digest = sha512.convert(bytes);

  return digest.toString();
}
