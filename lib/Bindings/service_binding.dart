import 'package:get/get.dart';
import '../Service/api/login_service.dart';
import '../Service/api/user_service.dart';
import '../Service/api/api_client.dart';
import '../Service/fetch_service.dart';
import '../Repository/user_repository.dart';
import '../Service/local/local_user_service.dart';
import '../Lifecycle/lifecycle_manager.dart';
import '../Service/local/local_login_service.dart';

class ServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiClient>(() => ApiClient(), fenix: true);
    Get.lazyPut<UserService>(() => UserService(), fenix: true);
    Get.lazyPut<LocalUserService>(() => LocalUserService());
    Get.lazyPut<LocalLoginService>(() => LocalLoginService(Get.find<LocalUserService>()));
    Get.lazyPut<LoginService>(() => LoginService());
    Get.lazyPut<UserRepository>(() => UserRepository(
      Get.find<UserService>(),
      Get.find<LocalUserService>(),
    ));
    Get.lazyPut<FetchService>(() => FetchService(Get.find<UserRepository>()));
    Get.put<LifecycleManager>(LifecycleManager(Get.find<FetchService>()));
  }
}
