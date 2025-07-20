import 'package:get/get.dart';
import '../Model/user_model.dart';
import '../Repository/user_repository.dart';
import 'user_controller.dart';

class UserDetailController extends GetxController {
  final UserRepository userRepository;
  final UserController userController = Get.find();
  User user;

  RxBool isLoading = false.obs;

  UserDetailController({
    required this.userRepository,
    required this.user,
  });

  Future<void> updateLastName(String newLastName) async {
    try {
      isLoading.value = true;
      await userRepository.updateUserLastName(user, newLastName);
      user.lastName.value = newLastName; // Controller içinde user güncellemesi
      userController.updateUserInList(user); // listeyi güncelle
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}


