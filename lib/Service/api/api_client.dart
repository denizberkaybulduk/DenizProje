import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static const _baseUrl = 'https://reqres.in/api';
  static const _headers = {
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

  
}
