import 'dart:convert';
import '../../Model/user_model.dart';
import 'api_client.dart';

class UserService {
  final ApiClient _client = ApiClient();

  Future<List<User>> fetchUsers() async {
    try {
      final response = await _client.getWithWholeUrl(
          'https://api.jsonbin.io/v3/b/687f44cc7b4b8670d8a53fa2', {
        'Content-Type': 'application/json',
        'X-Master-Key':
            '\$2a\$10\$qgX6xNGshFij5SNdn..5dujiYw/H5QDoAa9xY0bFPSLnpo3/Hf2yC',
      });

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
