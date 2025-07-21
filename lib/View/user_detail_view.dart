import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/user_detail_controller.dart';

class UserDetailView extends GetView<UserDetailController> {
  @override
  Widget build(BuildContext context) {
    final user = controller.user;

    return Scaffold(
      appBar: AppBar(title: const Text("Kullanıcı Detayı")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(user.avatar.value),
              ),
            ),
            const SizedBox(height: 16),
            Text("ID: ${user.id}"),
            Text("Email: ${user.email}"),
            Text("Ad: ${user.firstName.value}"),
            Obx(() => Text("Soyad: ${user.lastName.value}")),
            const SizedBox(height: 16),
            TextField(
              controller: controller.lastNameController,
              decoration: const InputDecoration(labelText: "Soyad (Düzenlenebilir)"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.updateLastName,
              child: const Text("Soyadı Güncelle"),
            ),
          ],
        ),
      ),
    );
  }
}
