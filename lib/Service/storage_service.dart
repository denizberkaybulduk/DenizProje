 import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  Future<void> saveLoginInfo(String email, String password, bool rememberMe) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    await prefs.setBool('rememberMe', rememberMe);
  }

  Future<Map<String, dynamic>> getLoginInfo() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'email': prefs.getString('email') ?? '',
      'password': prefs.getString('password') ?? '',
      'rememberMe': prefs.getBool('rememberMe') ?? false,
    };
  }

  Future<void> clearLoginInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
