import '../Model/user_model.dart';
import '../Service/api/user_service.dart';
import 'package:collection/collection.dart';



class UserRepository {
  final UserService _apiService;


  UserRepository(this._apiService);

  Future<List<User>> fetchUsers() async {
    final apiUsers = await _apiService.fetchUsers();


    // API verilerini local ile birleştir
    final mergedUsers = apiUsers.map((apiUser) {
  // localUsers'da eşleşen user varsa getir yoksa null döndür


  return apiUser;
}).toList();


    // Local dosyayı güncelle (merge edilmiş hali kaydet)

    return mergedUsers;
  }

  

  
}
