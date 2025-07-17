import 'dart:convert';
import '../../Model/user_model.dart';
import 'api_client.dart';

class UserService {
  final ApiClient _client = ApiClient();

  Future<List<User>> fetchUsers() async {
    try {
      final response = await _client.get('/users?page=1');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> usersJson = data['data'];
        return usersJson.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Kullanıcıları getirirken hata oluştu.');
      }
    } catch (e) {
      print('Hata: $e');
      return [];
    }
  }
}
