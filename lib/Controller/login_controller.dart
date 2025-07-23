import 'package:get/get.dart';
import 'auth_controller.dart';

class LoginController extends GetxController {
  final RxString email = ''.obs;
  final RxString password = ''.obs;
  final RxBool rememberMe = false.obs;
  final RxBool isLoading = false.obs;
  final RxString loginError = ''.obs;

  final authController = Get.find<AuthController>();

  Future<void> login() async {
    isLoading.value = true;
    loginError.value = '';

    final success = await authController.login(email.value, password.value, rememberMe.value);
    if (!success) {
      loginError.value = 'Giriş başarısız. Lütfen bilgilerinizi kontrol edin.';
    }

    isLoading.value = false;
  }
}
