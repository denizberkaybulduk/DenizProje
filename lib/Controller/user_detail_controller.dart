import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../Model/user_model.dart';

class UserDetailController extends GetxController {
  final User user;
  late final TextEditingController lastNameController;

  UserDetailController(this.user) {
    lastNameController = TextEditingController(text: user.lastName.value);
  }

  void updateLastName() {
    user.lastName.value = lastNameController.text;
    
    Get.snackbar("Başarılı", "Soyad güncellendi.");
  }

  @override
  void onClose() {
    lastNameController.dispose();
    super.onClose();
  }
}
