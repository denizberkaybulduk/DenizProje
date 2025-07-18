import '../../Model/user_model.dart';
import 'local_user_service.dart';

class LocalLoginService {
  final LocalUserService _localUserService;

  LocalLoginService(this._localUserService);

  Future<bool> login(String email, String password) async {
    final users = await _localUserService.getUsers();
    final user = users.firstWhere(
      (u) => u.email.value == email && u.password.value == password,
      orElse: () => User(id: 0, email: '', firstName: '', lastName: '', avatar: '', isError: true),
    );
    return !user.isError.value;
  }
}
