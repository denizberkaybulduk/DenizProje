import 'dart:convert';
import 'api_client.dart';

class LoginService {
  final ApiClient _client = ApiClient();

  Future<bool> login(String email, String password) async {
    try {
      final response = await _client.post('/login', {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Login successful, token: ${data['token']}');
        
        return true;
      } else {
        final errorData = jsonDecode(response.body);
        print('Login failed: ${errorData['error']}');
        return false;
      }
    } catch (e) {
      print('Login exception: $e');
      return false;
    }
  }
}
