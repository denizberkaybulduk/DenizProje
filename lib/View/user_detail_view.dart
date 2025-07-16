import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Model/user_model.dart';

class UserDetailView extends StatefulWidget {
  final User user;

  const UserDetailView({super.key, required this.user});

  @override
  State<UserDetailView> createState() => _UserDetailViewState();
}

class _UserDetailViewState extends State<UserDetailView> {
  late TextEditingController _lastNameController;

  @override
  void initState() {
    super.initState();
    _lastNameController = TextEditingController(text: widget.user.lastName.value);
  }

  @override
  void dispose() {
    _lastNameController.dispose();
    super.dispose();
  }

  void _updateLastName() {
    // Şimdilik sadece local olarak güncelliyoruz.
    setState(() {
      widget.user.lastName.value = _lastNameController.text;
    });

    // Gerçek senaryoda: API'ye PATCH/PUT ile güncelleme isteği gönderilir.

    Get.snackbar("Başarılı", "Soyad güncellendi.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kullanıcı Detayı")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(widget.user.avatar.value),
              ),
            ),
            const SizedBox(height: 16),
            Text("ID: ${widget.user.id}"),
            Text("Email: ${widget.user.email}"),
            const SizedBox(height: 16),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: "Soyad (Düzenlenebilir)"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateLastName,
              child: const Text("Soyadı Güncelle"),
            ),
          ],
        ),
      ),
    );
  }
}
