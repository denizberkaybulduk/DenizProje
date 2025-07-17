
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../../Model/user_model.dart';

class LocalUserService {
  Future<String> _getFilePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/users.json';
  }

  Future<void> saveUsers(List<User> users) async {
    final file = File(await _getFilePath());
    final data = users.map((u) => u.toJsonLocal()).toList();
    await file.writeAsString(jsonEncode(data));
  }

  Future<List<User>> getUsers() async {
    try {
      final file = File(await _getFilePath());
      final content = await file.readAsString();
      final List<dynamic> jsonList = jsonDecode(content);
      return jsonList.map((e) => User.fromJsonLocal(e)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> updateUser(User user) async {
    final users = await getUsers();
    final index = users.indexWhere((u) => u.id.value == user.id.value);
    if (index != -1) {
      users[index] = user;
      await saveUsers(users);
    }
  }

  Future<bool> login(String email, String password) async {
    final users = await getUsers();
    final user = users.firstWhere(
      (u) => u.email.value == email && u.id.value.toString() == password,
      orElse: () => User(id: 0, email: '', firstName: '', lastName: '', avatar: '', isError: true),
    );
    return user.isError.value == false;
  }
}

