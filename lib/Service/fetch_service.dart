import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Service/api/user_service.dart';
import '../../Model/user_model.dart';
import 'package:get/get.dart';
import '../Error/error_handler.dart';
import '../Model/app_error.dart';

class FetchService {
  final UserService userService;
  final RxList<User> users = <User>[].obs;
  Timer? _timer;

  FetchService(this.userService);

  void startFetching() {
    _timer ??= Timer.periodic(Duration(seconds: 3), (_) => fetch());
    fetch(); // ilk çağrı
  }

  void stopFetching() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> fetch() async {
  try {
    final result = await userService.fetchUsers()
        .timeout(const Duration(seconds: 10));
    if (result.isEmpty) {
      throw AppError(
        type: AppErrorType.notFound,
        message: 'Hiçbir kullanıcı verisi bulunamadı.',
      );
    }

    users.assignAll(result);
  } catch (e) {
    final appError = e is AppError ? e : ErrorHandler.handle(e);
    print('[FetchService] Hata: $appError');

    Get.snackbar(
      'Hata',
      appError.message,
      backgroundColor: Colors.red.shade100,
      colorText: Colors.red.shade900,
      snackPosition: SnackPosition.BOTTOM,
    );

    users.clear();
  }
}
}
