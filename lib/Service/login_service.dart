import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  final String baseUrl = "https://reqres.in/api";

  Future<bool> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
  // API başarılı yanıt döndü
  final data = jsonDecode(response.body);

  // Örnek: Token varsa kaydet veya döndür
  final token = data['token'];
  if (token != null) {
    // İstersen token'ı saklayabiliriz, örneğin GetStorage veya SharedPreferences ile
    // await storage.write('token', token);
    return true; // Login başarılı
  } else {
    // Token yoksa da hata kabul edebiliriz
    return false;
  }
} else {
  // Hata durumu, örneğin 400, 401 gibi kodlar
  // İstersen response.body içeriğini loglayabilir veya hata mesajı çıkarabilirsin
  print('Login failed: ${response.statusCode} - ${response.body}');
  return false;
}

  }
}
