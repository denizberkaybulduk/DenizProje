import 'package:get/get.dart';
import 'api/login_service.dart';
import 'fetch_service.dart';
import '../Controller/login_controller.dart';
import '../Service/storage_service.dart';
import '../Error/error_handler.dart';

class AuthService {
  final LoginService loginService;
  final StorageService storage;
  final FetchService fetchService;

  AuthService({
    required this.loginService,
    required this.storage,
    required this.fetchService,
  });

  Future<void> handleStartup() async {
    try {
      final loginController = Get.find<LoginController>();
      final loginInfo = await storage.getLoginInfo();
      final rememberMe = loginInfo['rememberMe'] == true;

      if (rememberMe) {
        loginController.email.value = loginInfo['email'] ?? '';
        loginController.password.value = loginInfo['password'] ?? '';

        final success = await loginService.login(
          loginController.email.value,
          loginController.password.value,
        );

        if (!success) {
          Get.offNamed('/login');
          return;
        }
      }

      await fetchService.fetch();
      Get.offNamed('/users');
    } catch (error) {
      final appError = ErrorHandler.handle(error);
      Get.snackbar("Hata", appError.message, snackPosition: SnackPosition.BOTTOM);
      Get.offNamed('/login');
    }
  }

  Future<bool> loginWith({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    try {
      final success = await loginService.login(email, password);
      if (!success) return false;

      if (rememberMe) {
        await storage.saveLoginInfo(email, password, rememberMe);
      } else {
        await storage.clearLoginInfo();
      }

      await fetchService.fetch();
      Get.offNamed('/users');
      return true;
    } catch (error) {
      final appError = ErrorHandler.handle(error);
      Get.snackbar("Giriş Hatası", appError.message, snackPosition: SnackPosition.BOTTOM);
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await storage.clearLoginInfo();
      Get.offAllNamed('/login');
    } catch (error) {
      final appError = ErrorHandler.handle(error);
      Get.snackbar("Çıkış Hatası", appError.message, snackPosition: SnackPosition.BOTTOM);
    }
  }
}
