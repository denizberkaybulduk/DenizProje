import 'package:get/get.dart';

class Task {
  RxInt id;
  RxString name;
  RxString type;
  RxString time;
  RxBool isError;

  Task({
    required int id,
    required String name,
    required String type,
    required String time,
    bool? isError,
  })  : id = id.obs,
        name = name.obs,
        type = type.obs,
        time = time.obs,
        isError = (isError ?? false).obs;

  factory Task.fromJson(Map<String, dynamic> json) {
    bool hasError = false;
    if ((json['name'] == null || json['name'].toString().isEmpty) ||
        (json['type'] == null || json['type'].toString().isEmpty) ||
        !_isValidTimeFormat(json['time'] ?? '')) {
      hasError = true;
    }

    return Task(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      time: json['time'] ?? '',
      isError: hasError,
    );
  }

  static bool _isValidTimeFormat(String value) {
    final regex = RegExp(r'^\d{2}:\d{2}-\d{2}:\d{2}$');
    return regex.hasMatch(value);
  }
}
