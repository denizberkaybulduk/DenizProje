import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../Model/user_model.dart';
import '../Service/api/user_service.dart';

class UserController extends GetxController with WidgetsBindingObserver {
  final UserService _service = UserService();

  var users = <User>[].obs;
  Timer? _timer;

  bool _isAppInForeground = true;
  bool _isVisible = false;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    _fetchUsers();
  }

  @override
  void onClose() {
    _stopFetching();
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  // App lifecycle değişikliklerini dinle
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _isAppInForeground = (state == AppLifecycleState.resumed);
    _updateFetchingState();
  }

  // UI görünürlük kontrolünden çağrılır
  void onVisibilityChanged(bool visible) {
    _isVisible = visible;
    _updateFetchingState();
  }

  void _updateFetchingState() {
    if (_isAppInForeground && _isVisible) {
      _startFetching();
    } else {
      _stopFetching();
    }
  }

  void _startFetching() {
    if (_timer != null && _timer!.isActive) return;

    _fetchUsers();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      _fetchUsers();
    });
  }

  void _stopFetching() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> _fetchUsers() async {
    final result = await _service.fetchUsers();
    users.value = result;
  }
}
