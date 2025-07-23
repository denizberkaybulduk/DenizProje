import 'package:get/get.dart';
import '../Model/user_model.dart';
import 'user_controller.dart';

class UserDetailController extends GetxController {

  final UserController userController = Get.find();
  User user;

  RxBool isLoading = false.obs;

  UserDetailController({

    required this.user,
  });

  Future<void> updateLastName(String newLastName) async {
    try {
      isLoading.value = true;

      user.lastName.value = newLastName; 
      userController.updateUserInList(user); 
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}


