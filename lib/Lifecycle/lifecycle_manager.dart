import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../Service/fetch_service.dart';

class LifecycleManager with WidgetsBindingObserver {
  final FetchService fetchService;

  bool _isAppInForeground = true;
  bool _isVisible = true;

  LifecycleManager(this.fetchService);

  void init() {
    WidgetsBinding.instance.addObserver(this); 
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    fetchService.stopFetching();
  }

  void onVisibilityChanged(bool visible) {
    _isVisible = visible;
    _updateFetching();
  }

  void _updateFetching() {
    if (_isAppInForeground && _isVisible) {
      fetchService.startFetching();
    } else {
      fetchService.stopFetching();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _isAppInForeground = (state == AppLifecycleState.resumed);
    _updateFetching();
  }
}
