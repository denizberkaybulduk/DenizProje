import 'dart:async';
import 'package:get/get.dart';
import '../Model/user_model.dart';
import '../Service/fetch_service.dart';

class FetchController extends GetxController {
  final FetchService _service = FetchService();

  var users = <User>[].obs;
  Timer? _timer;

  final RxBool isAppInForeground;
  final RxBool isPageVisible;

  FetchController({
    required this.isAppInForeground,
    required this.isPageVisible,
  });

  @override
  void onInit() {
    super.onInit();

    // Lifecycle veya görünürlük değişince fetch işlemini güncelle
    everAll([isAppInForeground, isPageVisible], (_) {
      _updateFetchingState();
    });
  }

  void _updateFetchingState() {
    bool shouldFetch = isAppInForeground.value && isPageVisible.value;

    if (shouldFetch && (_timer == null || !_timer!.isActive)) {
      _startFetching();
    } else if (!shouldFetch) {
      _stopFetching();
    }
  }

  void _startFetching() {
    _fetchUsers();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) => _fetchUsers());
  }

  void _stopFetching() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> _fetchUsers() async {
    final result = await _service.fetchUsers();
    users.value = result;
  }

  @override
  void onClose() {
    _stopFetching();
    super.onClose();
  }
}
