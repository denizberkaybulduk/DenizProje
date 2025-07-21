import 'package:flutter_application_1/Binding/login_binding.dart';
import 'package:get/get.dart';
import 'View/splash_view.dart';
import 'View/user_list_view.dart';
import 'View/login_view.dart';
import 'View/user_detail_view.dart';
import 'Binding/user_detail_binding.dart';
import 'Binding/global_binding.dart';
import 'Binding/user_list_binding.dart';

class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
  static const users = '/users';
  static const userDetail = '/userDetail';

  static final routes = [
  GetPage(
    name: splash,
    page: () => SplashView(),
    binding: GlobalBinding(), 
  ),
  GetPage(
    name: login,
    page: () => LoginView(),
    binding: LoginBinding(),
  ),
  GetPage(
    name: users,
    page: () => UserListView(),
    binding: UserListBinding(),  
  ),
  GetPage(
    name: userDetail,
    page: () => UserDetailView(),
    binding: UserDetailBinding(),
  ),
];

}

