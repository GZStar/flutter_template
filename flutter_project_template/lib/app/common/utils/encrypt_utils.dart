import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

var _key = 'ZniHsGZunPD43fbc';
var _iv = '0000000000000000';

class EncryptUtils {
  /// Base64编码
  static String encodeBase64(String data) {
    return base64Encode(utf8.encode(data));
  }

  /// Base64解码
  static String decodeBase64(String data) {
    return String.fromCharCodes(base64Decode(data));
  }

  /// md5 加密
  static String encodeMd5(String data) {
    var content = const Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  /// AES加密
  static aesEncrypt(plainText) {
    try {
      final key = Key.fromUtf8(_key);
      final iv = IV.fromUtf8(_iv);
      final encrypter = Encrypter(AES(key, mode: AESMode.ecb));
      final encrypted = encrypter.encrypt(plainText, iv: iv);
      return encrypted.base64;
    } catch (err) {
      return plainText;
    }
  }

  /// AES解密
  static dynamic aesDecrypt(encrypted) {
    try {
      final key = Key.fromUtf8(_key);
      final iv = IV.fromUtf8(_iv);
      final encrypter = Encrypter(AES(key, mode: AESMode.ecb));
      final decrypted = encrypter.decrypt64(encrypted, iv: iv);
      return decrypted;
    } catch (err) {
      return encrypted;
    }
  }
}
