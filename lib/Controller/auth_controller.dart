import 'dart:convert';

import 'package:get/get.dart';
import '../../Service/api_client.dart';
import '../../Service/storage_service.dart';
import 'user_list_page_controller.dart';

class AuthController extends GetxController {
  final ApiClient _apiClient = ApiClient();
  final StorageService _storageService = StorageService();

  final RxString email = ''.obs;
  final RxString password = ''.obs;
  String token = '';

  final RxBool rememberMe = false.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;


  Future<void> login({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final response = await _apiClient.post('/login', {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        if (token != null) {
          _apiClient.setToken(token);
          if (rememberMe.value) {
            await _storageService.saveLoginInfo(token, rememberMe.value);
          }
          await successLoginProcesses();
        }
      } else {
        errorMessage.value = 'Token alınamadı.';
      }
    } catch (e) {
      errorMessage.value = 'Bir hata oluştu: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future successLoginProcesses() async {
    final userController = Get.find<UserListPageController>();
    await userController.fetchUsers();
    Get.offAllNamed('/users');
  }

  Future<void> handleStartup() async {
    bool result = await tryAutoLogin();
    if (result) {
      await successLoginProcesses();
    } else {
      if (!rememberMe.value) {
        Get.offAllNamed('/login');
      }
    }
  }

  Future<bool> tryAutoLogin() async {
    final saved = await _storageService.getLoginInfo();
    token = saved['token'] ?? '';
    rememberMe.value = saved['rememberMe'] ?? false;

    if (token.isNotEmpty && rememberMe.value) {
      _apiClient.setToken(token);
      return true;
    } else {
      return false;
    }
  }

  Future<void> logout() async {
    final userController = Get.find<UserListPageController>();
    await _storageService.clearLoginInfo();
    userController.users.clear();
    Get.offAllNamed('/login');
  }
}
