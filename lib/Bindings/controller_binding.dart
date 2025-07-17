import 'package:get/get.dart';
import '../Controller/login_controller.dart';
import '../Controller/user_controller.dart';


class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<UserController>(() => UserController());
    Get.lazyPut<UserController>(() => UserController());
  }
}
