import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageClass {
  Future<String?> getUserToken(String keyToken) async {
    final token = await const FlutterSecureStorage().read(key: keyToken);
    return token;
  }

  Future<void> saveUserToken(String keyToken, token) async {
    await const FlutterSecureStorage().write(key: keyToken, value: token);
  }

  Future<void> deleteUserToken(String keyToken) async {
    const FlutterSecureStorage().delete(key: keyToken);
  }
}
