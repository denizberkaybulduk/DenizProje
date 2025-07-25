/*

import '../Model/app_error.dart';
import 'dart:io';
import 'dart:async';

class ErrorHandler {
  static AppError handle(dynamic error) {
    if (error is SocketException) {
      return AppError(type: AppErrorType.network, message: 'İnternet bağlantısı yok.');
    } else if (error is HttpException) {
      return AppError(type: AppErrorType.server, message: 'Sunucu hatası.');
    } else if (error is FormatException) {
      return AppError(type: AppErrorType.server, message: 'Yanıt formatı hatalı.');
    } else if (error is TimeoutException) {
      return AppError(type: AppErrorType.timeout, message: 'İstek zaman aşımına uğradı.');
    } else {
      return AppError(type: AppErrorType.unknown, message: 'Beklenmeyen bir hata oluştu.');
    }
  }
}

*/