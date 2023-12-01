import 'dart:convert';
import 'package:crypto/crypto.dart';

class AuthenticationParams {
  final String publicKey;
  final String privateKey;
  final String ts = DateTime.now().millisecondsSinceEpoch.toString();
  late String hash;

  AuthenticationParams({required this.publicKey, required this.privateKey}) {
    hash = generateHash();
  }

  String generateHash() {
    return md5.convert(utf8.encode(ts + privateKey + publicKey)).toString();
  }
}
