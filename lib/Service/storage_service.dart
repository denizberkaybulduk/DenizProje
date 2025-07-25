 import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  Future<void> saveLoginInfo(String token, bool rememberMe) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setBool('rememberMe', rememberMe);
  }

  Future<Map<String, dynamic>> getLoginInfo() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'token': prefs.getString('token') ?? '',
      'rememberMe': prefs.getBool('rememberMe') ?? false,
    };
  }

  Future<void> clearLoginInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
