import 'package:get/get.dart';
import '../Service/api/login_service.dart';

class LoginController extends GetxController {
  final LoginService _service = LoginService();

  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;
  var loginError = ''.obs;

  Future<void> login() async {
    isLoading.value = true;
    loginError.value = '';

    bool success = await _service.login(email.value, password.value);

    if (success) {
      // Login başarılı, anasayfaya yönlendirme yapabiliriz
      Get.offNamed('/users'); // örnek rota
    } else {
      loginError.value = "Giriş başarısız. Lütfen bilgilerinizi kontrol edin.";
    }
    isLoading.value = false;
  }
}
