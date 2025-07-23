import 'package:get/get.dart';
import '../Service/auth_service.dart';

class LoginController extends GetxController {
  final AuthService _service = Get.find<AuthService>();

  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;
  var loginError = ''.obs;
  var rememberMe = false.obs;

  Future<void> login() async {
    isLoading.value = true;
    loginError.value = '';

    final success = await _service.loginWith(
      email: email.value,
      password: password.value,
      rememberMe: rememberMe.value,
    );

    if (!success) {
      loginError.value = "Giriş başarısız. Lütfen bilgilerinizi kontrol edin.";
    }

    isLoading.value = false;
  }
}
