import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'dart:math' as math;

/// Parse cookie string into a map
Map<String, String> parseCookieString(String? cookie) {
  if (cookie == null || cookie.isEmpty) return {};

  final result = <String, String>{};
  final cookies = cookie.split(';');

  for (final cookiePair in cookies) {
    final trimmed = cookiePair.trim();
    if (trimmed.isEmpty) continue;

    final separatorIndex = trimmed.indexOf('=');
    if (separatorIndex == -1) continue;

    final key = trimmed.substring(0, separatorIndex).trim();
    final value = trimmed.substring(separatorIndex + 1).trim();

    if (key.isNotEmpty) {
      result[key] = value;
    }
  }

  return result;
}

/// Generate SHA-1 hash string
String sha1Hash(String input) {
  final bytes = utf8.encode(input);
  final digest = sha1.convert(bytes);
  return digest.toString();
}

String generateRandomString(int length) {
  const chars =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_';
  final rand = math.Random.secure();

  return List.generate(length, (_) => chars[rand.nextInt(chars.length)]).join();
}
