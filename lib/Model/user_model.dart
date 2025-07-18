import 'package:get/get.dart';

class User {
  final RxInt id;
  final RxString email;
  final RxString firstName;
  final RxString lastName;
  final RxString avatar;
  final RxString password;
  final RxString themeColor;
  final RxBool isError;          
  final RxString errorMessage;

  User({
    required int id,
    required String email,
    required String firstName,
    required String lastName,
    required String avatar,
    String? password,
    String? themeColor,
    bool isError = false,
    String errorMessage = '',
  })  : id = id.obs,
        email = email.obs,
        firstName = firstName.obs,
        lastName = lastName.obs,
        avatar = avatar.obs,
        password = (password ?? '').obs,
        themeColor = (themeColor ?? '').obs,
        isError = isError.obs,
        errorMessage = errorMessage.obs;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }

  factory User.fromJsonLocal(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      avatar: json['avatar'],
      password: json['password'],
      themeColor: json['themeColor'],
      isError: json['hasError'] ?? false,
      errorMessage: json['errorMessage'] ?? '',
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
      'isError': isError.value,
      'errorMessage': errorMessage.value,
    };
  }
}
