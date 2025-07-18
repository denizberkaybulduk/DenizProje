
import 'package:flutter/material.dart';
import '/Controller/login_controller.dart';
import 'package:get/get.dart';
import 'routes.dart';
import 'Controller/user_controller.dart';


void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  Get.put(LoginController());
  Get.put(UserController());
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

