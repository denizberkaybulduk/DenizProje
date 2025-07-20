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

  void updateUserInList(User updatedUser) {
    final index = users.indexWhere((u) => u.id.value == updatedUser.id.value);
    if (index != -1) {
      users[index] = updatedUser;
    }
  }

  
}


