import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorageService {
  static final FlutterSecureStorage storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static Future<void> saveToken(String token) async {
    await storage.write(key: "access_token", value: token);
  }

  static Future<String?> getToken() async {
    return await storage.read(key: "access_token");
  }

  static Future<void> deleteToken() async {
    await storage.delete(key: "access_token");
  }

  static Future<void> saveMyId(String myUserId) async {
    await storage.write(key: "my_user_id", value: myUserId);
  }

  static Future<String?> getMyId() async {
    return await storage.read(key: "my_user_id");
  }

  static Future<void> deleteMyId() async {
    await storage.delete(key: "my_user_id");
  }
}
