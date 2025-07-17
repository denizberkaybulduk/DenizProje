import '../Model/user_model.dart';
import '../Service/api/user_service.dart';
import '../Service/local/local_user_service.dart';

class UserRepository {
  final UserService _api;
  final LocalUserService _local;

  UserRepository(this._api, this._local);

  Future<List<User>> fetchUsers() async {
    try {
      final users = await _api.fetchUsers();
      await _local.saveUsers(users);
      return users;
    } catch (_) {
      return await _local.getUsers();
    }
  }
}
