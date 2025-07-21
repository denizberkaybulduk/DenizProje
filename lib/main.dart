
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Binding/global_binding.dart';
import 'package:flutter_application_1/Binding/login_binding.dart';
import 'package:flutter_application_1/Binding/user_list_binding.dart';
import 'package:get/get.dart';
import 'routes.dart';



void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  LoginBinding().dependencies();
  GlobalBinding().dependencies();
  UserListBinding().dependencies();
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

