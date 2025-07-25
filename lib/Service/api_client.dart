import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/user_model.dart';

class ApiClient {
  String? _token;

  void setToken(String token) {
    _token = token;
  }

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
    final url = Uri.parse(path);
    return http.get(url, headers: newHeader);
  }

  
}
