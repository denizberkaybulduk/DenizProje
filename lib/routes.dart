import 'package:get/get.dart';
import 'View/splash_view2.dart';
import 'View/Task_List_Page2.dart';
import 'View/task_detail.dart';

class AppRoutes {
  static const splash = '/splash';
  static const tasks = '/tasks';
  static const taskDetail = '/taskDetail';

  static final routes = [
    GetPage(name: splash, page: () => SplashView()),
    GetPage(name: tasks, page: () => TaskListView()),
    GetPage(name: taskDetail, 
    page: () => TaskDetailPage(task: Get.arguments)),
  ];
}
