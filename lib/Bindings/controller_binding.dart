import 'package:flutter_application_1/Service/api/user_service.dart';
import 'package:get/get.dart';
import '../Controller/login_controller.dart';
import '../Controller/user_controller.dart';
import '../Controller/user_detail_controller.dart';


class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<UserController>(() => UserController(Get.find<UserService>()));
    Get.lazyPut<UserDetailController>(() {
      final user = Get.arguments;
      return UserDetailController(
        user: user,
      );
    });
  }
}
