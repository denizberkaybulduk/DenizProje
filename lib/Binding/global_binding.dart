import 'package:get/get.dart';
import '../Controller/fetch_controller.dart';
import '../Service/fetch_service.dart';
import '../Service/api_client.dart';
import '../Lifecycle/lifecycle_manager.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiClient());
    Get.put(FetchService());

    // LifecycleManager singleton olarak başlatılır
    final lifecycleManager = Get.put(LifecycleManager());

    // Sayfa görünürlüğünü tutacak observable, view içinde güncellenecek
    final pageVisible = false.obs;

    // FetchController'a lifecycle ve görünürlük değişkenleri verilir
    Get.put(FetchController(
      isAppInForeground: lifecycleManager.isAppInForeground,
      isPageVisible: pageVisible,
    ));
  }
}
