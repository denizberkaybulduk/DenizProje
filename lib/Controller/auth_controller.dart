import 'package:get/get.dart';
import '../Service/storage_service.dart';
import '../Service/api/login_service.dart';
import '../routes.dart';

class AuthController extends GetxController {
  final StorageService _storage = StorageService();
  final LoginService _loginService = LoginService();

  final RxBool isLoggedIn = false.obs;

  Future<void> handleStartup() async {
    final loginInfo = await _storage.getLoginInfo();
    final rememberMe = loginInfo['rememberMe'] as bool;

    if (rememberMe) {
      final email = loginInfo['email'];
      final password = loginInfo['password'];

      final success = await _loginService.login(email, password);
      if (success) {
        isLoggedIn.value = true;
        Get.offAllNamed(AppRoutes.users);
        return;
      }
    }

    Get.offAllNamed(AppRoutes.login);
  }

  Future<bool> login(String email, String password, bool rememberMe) async {
    final success = await _loginService.login(email, password);
    if (success) {
      if (rememberMe) {
        await _storage.saveLoginInfo(email, password, rememberMe);
      } else {
        await _storage.clearLoginInfo();
      }
      isLoggedIn.value = true;
      Get.offAllNamed(AppRoutes.users);
    }
    return success;
  }

  Future<void> logout() async {
    await _storage.clearLoginInfo();
    isLoggedIn.value = false;
    Get.offAllNamed(AppRoutes.login);
  }
}
