import 'package:encrypt/encrypt.dart' as encrypt;

String encryptCredential(String plainText, String secretKey) {
  final key =
      encrypt.Key.fromUtf8(secretKey.padRight(32, '0').substring(0, 32));
  final iv = encrypt.IV.fromLength(16);

  final encrypter = encrypt.Encrypter(encrypt.AES(key));

  final encrypted = encrypter.encrypt(plainText, iv: iv);
  return '${iv.base64}:${encrypted.base64}';
}

String decryptCredential(String encryptedTextWithIV, String secretKey) {
  final parts = encryptedTextWithIV.split(':');
  final iv = encrypt.IV.fromBase64(parts[0]);
  final encryptedText = parts[1];

  final key =
      encrypt.Key.fromUtf8(secretKey.padRight(32, '0').substring(0, 32));
  final encrypter = encrypt.Encrypter(encrypt.AES(key));

  try {
    final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
    return decrypted;
  } catch (e) {
    print('Decryption error: $e');
    return '';
  }
}
