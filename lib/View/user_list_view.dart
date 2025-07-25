import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../Lifecycle/lifecycle_manager.dart';
import '../Controller/user_list_page_controller.dart';


class UserListView extends StatefulWidget {
  const UserListView({super.key});

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  final userListPageController = Get.find<UserListPageController>();
  final LifecycleManager lifecycleManager = Get.find<LifecycleManager>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kullanıcı Listesi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Get.find<AuthController>().logout();
            },
          )
        ],
      ),
      body: VisibilityDetector(
        key: const Key('user-list-view'),
        onVisibilityChanged: (info) {
          lifecycleManager.onVisibilityChanged(info.visibleFraction > 0);
        },
        child: Obx(() {
          if (userListPageController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (userListPageController.users.isEmpty) {
            return const Center(child: Text('Kullanıcı bulunamadı.'));
          }
          return ListView.builder(
            itemCount: userListPageController.users.length,
            itemBuilder: (context, index) {
              final user = userListPageController.users[index];
              return ListTile(
                title: Text(user.email.value),
                subtitle: Text("ID: ${user.id.value}"),
                onTap: () {
                  Get.toNamed('/userDetail', arguments: user);
                },
              );
            },
          );
        }),
      ),
    );
  }
}
