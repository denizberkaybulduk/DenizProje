import 'package:flutter_application_1/Bindings/controller_binding.dart';
import 'package:get/get.dart';
import 'View/splash_view.dart';
import 'View/user_list_view.dart';
import 'View/login_view.dart';
import 'View/user_detail_view.dart';

class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
  static const users = '/users';
  static const userDetail = '/userDetail';

  static final routes = [
    GetPage(name: splash, page: () => const SplashView()),
    GetPage(name: login, page: () => LoginView()),
    GetPage(name: users, page: () => UserListView()),
    GetPage(
      name: userDetail,
      page: () => UserDetailView(),
      binding: ControllerBinding(),),
  ];
}

