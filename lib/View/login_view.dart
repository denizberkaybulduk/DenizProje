import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/login_controller.dart';

class LoginView extends StatelessWidget {
  final LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Giriş Yap")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) => controller.email.value = value,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              onChanged: (value) => controller.password.value = value,
              obscureText: true,
              decoration: InputDecoration(labelText: "Şifre"),
            ),
            const SizedBox(height: 20),
            if (controller.loginError.isNotEmpty)
              Text(
                controller.loginError.value,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: controller.isLoading.value ? null : () => controller.login(),
              child: controller.isLoading.value 
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text("Giriş Yap"),
            ),
          ],
        )),
      ),
    );
  }
}
