import 'package:get/get.dart';

class User {
  final RxInt id;
  final RxString email;
  final RxString firstName;
  final RxString lastName;
  final RxString avatar;
  final RxBool isError;

  final RxString password;  
  final RxString themeColor; 

  User({
    required int id,
    required String email,
    required String firstName,
    required String lastName,
    required String avatar,
    bool? isError,
    String? password,
    String? themeColor,
  })  : id = id.obs,
        email = email.obs,
        firstName = firstName.obs,
        lastName = lastName.obs,
        avatar = avatar.obs,
        isError = (isError ?? false).obs,
        password = (password ?? '').obs,
        themeColor = (themeColor ?? '').obs;

  factory User.fromJson(Map<String, dynamic> json) {
    bool hasError = false;
    if (json['id'] == null ||
        json['email'] == null ||
        json['first_name'] == null ||
        json['last_name'] == null ||
        json['avatar'] == null) {
      hasError = true;
    }

    return User(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      avatar: json['avatar'] ?? '',
      isError: hasError,
    );
  }


  factory User.fromJsonLocal(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      avatar: json['avatar'] ?? '',
      password: json['password'] ?? '',
      themeColor: json['themeColor'] ?? '',
    );
  }


  Map<String, dynamic> toJsonLocal() {
    return {
      'id': id.value,
      'email': email.value,
      'firstName': firstName.value,
      'lastName': lastName.value,
      'avatar': avatar.value,
      'password': password.value,
      'themeColor': themeColor.value,
    };
  }
}
