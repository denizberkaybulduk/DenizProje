import 'package:get/get.dart';
import '../Service/login_service.dart';
import '../Service/fetch_service.dart';
import '../Service/api_client.dart';


class ServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiClient>(() => ApiClient(), fenix: true);
    Get.lazyPut<FetchService>(() => FetchService(), fenix: true);
    Get.lazyPut<LoginService>(() => LoginService());
  }
}
