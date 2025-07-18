import 'dart:async';
import 'package:get/get.dart';
import '../Model/user_model.dart';
import '../Repository/user_repository.dart';


class UserController extends GetxController {
  final UserRepository userRepository;

  var users = <User>[].obs;

  UserController(this.userRepository);

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  void fetchUsers() async {
    final fetchedUsers = await userRepository.fetchUsers();
    users.value = fetchedUsers;
  }

  void updateLastName(User user, String newLastName) async {
    user.lastName.value = newLastName;
    await userRepository.updateUser(user);
    users.refresh(); // UI'nın güncellenmesi için
  }
}


