import 'package:get/get.dart';
import 'View/splash_view2.dart';
import 'View/Task_List_Page2.dart';
import 'View/task_detail.dart';

class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
  static const users = '/users';
  static const userDetail = '/userDetail';

  static final routes = [
    GetPage(name: splash, page: () => SplashView()),
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: users, page: () => UserListPage()),
    GetPage(name: userDetail, page: () => UserDetailPage(user: Get.arguments)),
  ];
}

