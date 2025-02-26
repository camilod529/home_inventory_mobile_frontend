import 'package:hive/hive.dart';

class AuthLocalDataSource {
  static const String _tokenKey = 'auth_token';

  Future<void> saveToken(String token) async {
    var box = await Hive.openBox('authBox');
    await box.put(_tokenKey, token);
  }

  Future<String?> getToken() async {
    var box = await Hive.openBox('authBox');
    return box.get(_tokenKey);
  }

  Future<void> clearToken() async {
    var box = await Hive.openBox('authBox');
    await box.delete(_tokenKey);
  }
}
