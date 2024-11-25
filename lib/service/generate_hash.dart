import 'dart:convert';

import 'package:crypto/crypto.dart';

/// A utility class for generating secure hashes for transaction validation.
class GenerateHash {
  /// Generates a SHA-512 hash using the provided [salt] and [parameters].
  ///
  /// The [parameters] map contains key-value pairs that will be concatenated
  /// in the required order, separated by `|`. The [salt] is appended at the end
  /// of the concatenated string before hashing.
  ///
  /// Example usage:
  /// ```dart
  /// final hash = GenerateHash().generate(
  ///   salt: 'my_salt',
  ///   parameters: {
  ///     'param1': 'value1',
  ///     'param2': 'value2',
  ///   },
  /// );
  /// print(hash); // Outputs the SHA-512 hash
  /// ```
  String generate({
    required String salt,
    required Map<String, String> parameters,
  }) {
    // Concatenate parameters in the required order
    final concatenated = parameters.entries
        .map((entry) => entry.value)
        .join('|'); // Assuming '|' is the separator

    // Append salt
    final input = '$concatenated|$salt';

    // Compute SHA-512 hash
    final bytes = utf8.encode(input);
    final digest = sha512.convert(bytes);

    return digest.toString();
  }
}
