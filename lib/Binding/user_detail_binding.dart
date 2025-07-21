import 'package:get/get.dart';
import '../Controller/user_detail_controller.dart';
import '../Model/user_model.dart';

class UserDetailBinding extends Bindings {
  @override
  void dependencies() {
    final user = Get.arguments as User;
    Get.put(UserDetailController(user));
  }
}
