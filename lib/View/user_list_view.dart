import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/user_controller.dart';

class UserListView extends StatelessWidget {
  final controller = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kullanıcılar")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.users.length,
          itemBuilder: (context, index) {
            final user = controller.users[index];
            return ListTile(
              title: Text(user.email.value),
              subtitle: Text("ID: ${user.id.value.toString()}"),
              onTap: () {
                // Detay sayfasına yönlendirilebilir
              },
            );
          },
        );
      }),
    );
  }
}
