import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/user_model.dart';

class UserService {
  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse("https://reqres.in/api/users?page=1"));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List users = jsonData['data'];
      return users.map((userJson) => User.fromJson(userJson)).toList();
    } else {
      throw Exception("Kullanıcılar alınamadı");
    }
  }

  Future<User> fetchUserDetail(int id) async {
    final response = await http.get(Uri.parse("https://reqres.in/api/users/$id"));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return User.fromJson(jsonData['data']);
    } else {
      throw Exception("Kullanıcı detayı alınamadı");
    }
  }
}
