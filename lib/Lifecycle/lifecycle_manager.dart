import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LifecycleManager extends GetxService with WidgetsBindingObserver {
  final RxBool isAppInForeground = true.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    isAppInForeground.value = (state == AppLifecycleState.resumed);
  }
}
