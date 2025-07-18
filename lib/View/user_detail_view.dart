import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Model/user_model.dart';
import '../Controller/user_detail_controller.dart';

class UserDetailView extends StatelessWidget {
  final UserDetailController controller = Get.find<UserDetailController>();

  late final TextEditingController _lastNameController;

  UserDetailView({Key? key}) : super(key: key) {
    _lastNameController = TextEditingController(text: controller.user.lastName.value);
  }

  @override
  Widget build(BuildContext context) {
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
                backgroundImage: NetworkImage(controller.user.avatar.value),
              ),
            ),
            const SizedBox(height: 16),
            Text("ID: ${controller.user.id.value}"),
            Text("Email: ${controller.user.email.value}"),
            Text("Ad: ${controller.user.firstName.value}"),
            Obx(() => Text("Soyad: ${controller.user.lastName.value}")),
            const SizedBox(height: 16),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: "Soyad (Düzenlenebilir)"),
            ),
            const SizedBox(height: 20),
            Obx(() {
              if(controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return ElevatedButton(
                onPressed: () async {
                  final newLastName = _lastNameController.text.trim();
                  if (newLastName.isEmpty) {
                    Get.snackbar("Hata", "Soyad boş olamaz");
                    return;
                  }

                  controller.isLoading.value = true;
                  await controller.updateLastName(newLastName);
                  controller.isLoading.value = false;

                  Get.snackbar("Başarılı", "Soyad güncellendi.");
                },
                child: const Text("Soyadı Güncelle"),
              );
            }),
          ],
        ),
      ),
    );
  }
}
