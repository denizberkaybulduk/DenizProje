enum AppErrorType {
  network,
  server,
  unauthorized,
  notFound,
  timeout,
  unknown,
}

class AppError {
  final AppErrorType type;
  final String message;

  AppError({required this.type, required this.message});

  @override
  String toString() => 'AppError(type: $type, message: $message)';
}
