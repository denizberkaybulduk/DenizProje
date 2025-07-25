import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/auth_controller.dart';

class LoginView extends StatelessWidget {
  final AuthController controller = Get.find<AuthController>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Giriş Yap')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => controller.email.value = value
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Şifre'),
                  controller: passwordController,
                  obscureText: true,
                  onChanged: (value) => controller.password.value = value
                ),
                const SizedBox(height: 8),
                CheckboxListTile(
                  title: const Text("Beni Hatırla"),
                  value: controller.rememberMe.value,
                  onChanged: (val) {
                    if (val != null) {
                      controller.rememberMe.value = val;
                    }
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () => controller.login(
                          email: emailController.text.trim(),
                          password: passwordController.text),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Text('Giriş Yap'),
                ),
                if (controller.errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      controller.errorMessage.value,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            )),
      ),
    );
  }
}
