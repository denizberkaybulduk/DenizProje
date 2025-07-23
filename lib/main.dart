
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes.dart';
import 'Bindings/controller_binding.dart';
import 'Bindings/service_binding.dart';
import 'Lifecycle/lifecycle_manager.dart';




void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  ServiceBinding().dependencies();
  ControllerBinding().dependencies();
  Get.find<LifecycleManager>().init();
  runApp(const MyApp());
  

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.routes,
    );
  }
}

