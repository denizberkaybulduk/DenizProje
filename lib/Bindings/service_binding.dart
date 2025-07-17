import 'package:get/get.dart';
import '../Service/login_service.dart';
import '../Service/api/user_service.dart';
import '../Service/api/api_client.dart';


class ServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiClient>(() => ApiClient(), fenix: true);
    Get.lazyPut<UserService>(() => UserService(), fenix: true);
    Get.lazyPut<LoginService>(() => LoginService());
  }
}
