import 'package:get/get.dart';

class User {
  final RxString id;
  final RxString email;
  final RxString firstName;
  final RxString lastName;
  final RxString avatar;       


  User({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
    required String avatar,

  })  : id = id.obs,
        email = email.obs,
        firstName = firstName.obs,
        lastName = lastName.obs,
        avatar = avatar.obs;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      email: json['email'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }

}
