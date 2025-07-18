import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../Controller/user_controller.dart';
import '../Lifecycle/lifecycle_manager.dart';

class UserListView extends StatefulWidget {
  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  final userController = Get.find<UserController>();
  final LifecycleManager lifecycleManager = Get.find<LifecycleManager>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kullanıcılar")),
      body: VisibilityDetector(
        key: const Key('user-list-view'),
        onVisibilityChanged: (info) {
          lifecycleManager.onVisibilityChanged(info.visibleFraction > 0);
        },
        child: Obx(() {
          if (userController.users.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: userController.users.length,
            itemBuilder: (context, index) {
              final user = userController.users[index];
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
