import 'dart:async';
import '../../Model/user_model.dart';
import 'package:get/get.dart';
import '../Repository/user_repository.dart';

class FetchService {
  final UserRepository repository;
  final RxList<User> users = <User>[].obs;
  Timer? _timer;

  FetchService(this.repository);

  void startFetching() {
    _timer ??= Timer.periodic(Duration(seconds: 3), (_) => fetch());
    fetch(); // ilk çağrı
  }

  void stopFetching() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> fetch() async {
    final result = await repository.fetchUsers();
    users.assignAll(result);
  }
}
