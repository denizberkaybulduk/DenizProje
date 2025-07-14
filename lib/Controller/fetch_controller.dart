import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '/Controller/task_controller2.dart';
import '/Model/task_model.dart';

class FetchController extends GetxController with WidgetsBindingObserver {
  Timer? _timer;
  bool _isVisible = false; 

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);

    _fetchAndUpdateTasks();

    _timer = Timer.periodic(Duration(seconds: 5), (_) {
      if (_isVisible) {
        _fetchAndUpdateTasks();
      }
    });
  }

 
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _isVisible = true;
    } else {
      _isVisible = false;
    }
  }


  void setVisible(bool visible) {
    _isVisible = visible;
  }

  Future<void> _fetchAndUpdateTasks() async {
    try {
      final String response = await rootBundle.loadString('assets/data.json');
      final data = json.decode(response);
      final loadedTasks = List<Task>.from(
        data['tasks'].map((e) => Task.fromJson(e)),
      );

      final taskController = Get.find<TaskController>();
      taskController.tasks.assignAll(loadedTasks);
    } catch (e) {
      print('Görevleri yenilerken hata: $e');
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }
}
