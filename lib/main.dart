
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/task_filter_controller.dart';
import 'package:get/get.dart';
import 'routes.dart';
import 'Controller/task_controller2.dart';
import 'Controller/fetch_controller.dart';


void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  Get.put(FetchController());
  Get.put(TaskController());
  Get.put(TaskFilterController());
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

