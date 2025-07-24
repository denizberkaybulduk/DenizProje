import 'package:get/get.dart';
import '../Service/api_client.dart';
import '../Lifecycle/lifecycle_manager.dart';
import '../Service/storage_service.dart';
import '../Error/error_handler.dart';


class ServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ApiClient>(ApiClient());
    Get.lazyPut<StorageService>(() => StorageService());
    Get.put(ErrorHandler());
    Get.put<LifecycleManager>(LifecycleManager());
  }
}
