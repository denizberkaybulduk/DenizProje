import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Model/user_model.dart';
import '../../Service/api_client.dart';
import '../../Service/storage_service.dart';

class AuthController extends GetxController {
  final ApiClient _apiClient = ApiClient();
  final StorageService _storageService = StorageService();

  final RxString email = ''.obs;
  final RxString password = ''.obs;

  final RxBool rememberMe = false.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  final RxList<User> users = <User>[].obs;

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
        if (rememberMe.value) {
          await _storageService.saveLoginInfo(
            email,
            password,
            rememberMe.value,
          );
        }
        await successLoginProcesses();
      } else {
        errorMessage.value = 'Giriş başarısız. Hatalı e-posta veya şifre.';
      }
    } catch (e) {
      errorMessage.value = 'Bir hata oluştu: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future successLoginProcesses() async {
    await fetchUsers();
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
    email.value = saved['email'] ?? '';
    password.value = saved['password'] ?? '';
    rememberMe.value = saved['rememberMe'] ?? false;

    if (email.isNotEmpty && password.isNotEmpty && rememberMe.value) {
      return true;
      await login(email: email.value, password: password.value);
    } else {
      return false;
    }
  }

  Future<void> fetchUsers() async {
    try {
      final result = await _apiClient.fetchUsers();
      users.assignAll(result);
    } catch (e) {
      print('Kullanıcılar alınırken hata oluştu: $e');
      users.clear();
    }
  }

  Future<void> logout() async {
    await _storageService.clearLoginInfo();
    email.value = '';
    password.value = '';
    rememberMe.value = false;
    users.clear();
    Get.offAllNamed('/login');
  }
}
