import 'package:get/get.dart';
import '../Controller/user_controller.dart';
import '../Controller/user_detail_controller.dart';
import '../Controller/auth_controller.dart';


class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController()); 
    //Get.lazyPut<UserController>(() => UserController());
    Get.lazyPut<UserDetailController>(() {
      final user = Get.arguments;
      return UserDetailController(
        user: user,
      );
    });
  }
}
