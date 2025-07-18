import 'package:get/get.dart';
import '../Controller/login_controller.dart';
import '../Controller/user_controller.dart';
import '../Controller/user_detail_controller.dart';
import '../Repository/user_repository.dart';


class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<UserController>(() => UserController(Get.find<UserRepository>()));
    Get.lazyPut<UserDetailController>(() {
      final user = Get.arguments;
      return UserDetailController(
        userRepository: Get.find<UserRepository>(),
        user: user,
      );
    });
  }
}
