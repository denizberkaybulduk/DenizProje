import '../Model/user_model.dart';
import '../Service/api/user_service.dart';
import '../Service/local/local_user_service.dart';


class UserRepository {
  final UserService _apiService;
  final LocalUserService _localService;

  UserRepository(this._apiService, this._localService);

  Future<List<User>> fetchUsers() async {
    final apiUsers = await _apiService.fetchUsers();
    final localUsers = await _localService.getUsers();

    // API verilerini local ile birleştir
    final mergedUsers = apiUsers.map((apiUser) {
      final localMatch = localUsers.firstWhere(
        (u) => u.id.value == apiUser.id.value,
        orElse: () => apiUser,
      );

      // Local verileri koru
      apiUser.lastName.value = localMatch.lastName.value;
      apiUser.password.value = localMatch.password.value;
      apiUser.themeColor.value = localMatch.themeColor.value;

      return apiUser;
    }).toList();

    // Local dosyayı güncelle (merge edilmiş hali kaydet)
    await _localService.saveUsers(mergedUsers);
    return mergedUsers;
  }

  Future<void> updateUser(User user) async {
    await _localService.updateUser(user);
  }

  
}
