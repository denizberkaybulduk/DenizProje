import 'dart:async';
import 'package:get/get.dart';
import '../Controller/user_list_page_controller.dart';

class LifecycleManager {
  Timer? _timer;
  bool _isVisible = false;

  void onVisibilityChanged(bool isVisible) {
    _isVisible = isVisible;
    if (isVisible) {
      _startPeriodicFetch();
    } else {
      _stopPeriodicFetch();
    }
  }

  void _startPeriodicFetch() {
    if (_timer != null) return; 

    _timer = Timer.periodic(const Duration(seconds: 10), (_) async {
      await Get.find<UserListPageController>().fetchUsers();
    });
  }

  void _stopPeriodicFetch() {
    _timer?.cancel();
    _timer = null;
  }

  void dispose() {
    _stopPeriodicFetch();
  }
}
