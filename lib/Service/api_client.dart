import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/user_model.dart';

class ApiClient {
  final String _baseUrl = 'https://reqres.in/api';
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'x-api-key': 'reqres-free-v1',
  };

  Future<http.Response> post(String path, Map<String, dynamic> body) {
    final url = Uri.parse('$_baseUrl$path');
    return http.post(url, headers: _headers, body: jsonEncode(body));
  }

  Future<http.Response> get(String path) {
    final url = Uri.parse('$_baseUrl$path');
    return http.get(url, headers: _headers);
  }

  Future<http.Response> getWithWholeUrl(String path, var newHeader) {
    final url = Uri.parse('$path');
    return http.get(url, headers: newHeader);
  }

  Future<List<User>> fetchUsers() async {
    try {
      final response = await getWithWholeUrl(
        'https://api.jsonbin.io/v3/b/687f44cc7b4b8670d8a53fa2',
        {
          'Content-Type': 'application/json',
          'X-Master-Key':
              r'$2a$10$qgX6xNGshFij5SNdn..5dujiYw/H5QDoAa9xY0bFPSLnpo3/Hf2yC',
        },
      );

      print('Gelen statusCode: ${response.statusCode}');
      print('Gelen body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> usersJson = data['record']['data'];
        return usersJson.map((json) => User.fromJson(json)).toList();
      } else {
        // Detaylı hata mesajı oluştur
        String reason = 'Bilinmeyen hata';
        try {
          final decoded = jsonDecode(response.body);
          reason = decoded['message'] ?? decoded['error'] ?? response.body;
        } catch (_) {
          reason = response.body;
        }

        throw Exception('API Hatası [${response.statusCode}]: $reason');
      }
    } catch (e) {
      // Internet yok, timeout, parse hatası vs.
      print('API fetchUsers hatası: $e');
      throw Exception(
          'Kullanıcılar alınamadı. Lütfen internet bağlantınızı kontrol edinn.');
    }
  }
}
