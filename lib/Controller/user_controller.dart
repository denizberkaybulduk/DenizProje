import 'dart:async';
import 'package:flutter_application_1/Service/api/user_service.dart';
import 'package:get/get.dart';
import '../Model/user_model.dart';


class UserController extends GetxController {
  final UserService _userService;
  var users = <User>[].obs;
  var isLoading = true.obs;

  UserController(this._userService);

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  void fetchUsers() async {
    isLoading.value = true;
    final fetchedUsers = await _userService.fetchUsers();
    users.value = fetchedUsers;
    isLoading.value = false;
  }

  void updateUserInList(User updatedUser) {
    final index = users.indexWhere((u) => u.id.value == updatedUser.id.value);
    if (index != -1) {
      users[index] = updatedUser;
    }
  }

  
}


