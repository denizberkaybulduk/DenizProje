import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/auth_controller.dart';

class LoginView extends StatelessWidget {
  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Giriş Yap')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
              onChanged: (val) => controller.email.value = val,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Şifre'),
              obscureText: true,
              onChanged: (val) => controller.password.value = val,
            ),
            const SizedBox(height: 8),
            
            CheckboxListTile(
              title: Text("Beni Hatırla"),
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
              onPressed: controller.isLoading.value ? null : () => controller.login(),
              child: controller.isLoading.value
                  ? CircularProgressIndicator()
                  : Text('Giriş Yap'),
            ),

            if (controller.errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  controller.errorMessage.value,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        )),
      ),
    );
  }
}

