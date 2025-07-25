import 'dart:convert';
import 'package:flutter_application_1/Model/user_model.dart';
import 'package:get/get.dart';
import '../Service/api_client.dart';

class UserListPageController extends GetxController {
  final ApiClient _apiClient = Get.find();

  final RxList<User> users = <User>[].obs;
  final RxBool isLoading = false.obs;

  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;

      final response = await _apiClient.getWithWholeUrl(
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
        users.value = usersJson.map((json) => User.fromJson(json)).toList();
      } else {
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
      print('API fetchUsers hatası: $e');
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}

