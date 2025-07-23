import 'package:get/get.dart';
import '../Service/api/login_service.dart';
import '../Service/api/user_service.dart';
import '../Service/api/api_client.dart';
import '../Service/fetch_service.dart';
import '../Lifecycle/lifecycle_manager.dart';
import '../Service/storage_service.dart';
import '../Service/auth_service.dart';
import '../Error/error_handler.dart';


class ServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiClient>(() => ApiClient(), fenix: true);
    Get.lazyPut<StorageService>(() => StorageService());
    Get.put(ErrorHandler());
    Get.lazyPut(() => AuthService(
          loginService: Get.find(),
          storage: Get.find(),
          fetchService: Get.find(),
        ));
    Get.lazyPut<UserService>(() => UserService(), fenix: true);
    Get.lazyPut<LoginService>(() => LoginService());

    Get.lazyPut<FetchService>(() => FetchService(Get.find<UserService>()));
    Get.put<LifecycleManager>(LifecycleManager(Get.find<FetchService>()));
  }
}
