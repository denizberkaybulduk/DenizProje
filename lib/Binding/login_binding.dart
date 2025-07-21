import 'package:get/get.dart';
import '../Controller/login_controller.dart';
import '../Service/login_service.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginService());
    Get.put(LoginController());
  }
}
