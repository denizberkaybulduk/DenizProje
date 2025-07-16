import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../Controller/fetch_controller.dart';

class UserListView extends StatefulWidget {
  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  final fetchController = Get.put(FetchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kullanıcılar")),
      body: VisibilityDetector(
        key: const Key('user-list-view'),
        onVisibilityChanged: (info) {
          fetchController.onVisibilityChanged(info.visibleFraction > 0);
        },
        child: Obx(() {
          if (fetchController.users.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: fetchController.users.length,
            itemBuilder: (context, index) {
              final user = fetchController.users[index];
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
