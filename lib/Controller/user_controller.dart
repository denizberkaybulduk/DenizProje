import 'package:get/get.dart';
import '../Model/user_model.dart';
import '../Service/user_service.dart';

class UserController extends GetxController {
  var users = <User>[].obs;
  var isLoading = false.obs;

  final userService = UserService();

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  void fetchUsers() async {
    try {
      isLoading.value = true;
      users.value = await userService.fetchUsers();
    } catch (e) {
      Get.snackbar("Hata", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
