
import 'package:get/get.dart';
import '/Model/task_model.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs;
//itemler de obs olcak
  @override
  void onInit() {
    super.onInit();
    
  }

  

  void addThirtyMinutesToTimes() {
  for (var task in tasks) {
    final times = task.time.split('-'); 
    if (times.length == 2) {
      DateTime? startTime = _parseTime(times[0]);
      DateTime? endTime = _parseTime(times[1]);

      if(startTime!=null && startTime.hour<15 && startTime.hour>6){
        task.type.value = "Morning";
      } else {
        task.type.value = "Night";
      }

      if (startTime != null && endTime != null) {
        startTime = startTime.add(Duration(minutes: 30));
        endTime = endTime.add(Duration(minutes: 30));

        
        final newTime =
            "${_formatTime(startTime)}-${_formatTime(endTime)}";

        task.time.value = newTime;
      }
    }
  }
}


DateTime? _parseTime(String timeStr) {
  try {
    final parts = timeStr.split(':');
    if (parts.length == 2) {
      int hour = int.parse(parts[0]);
      int minute = int.parse(parts[1]);
      return DateTime(0, 1, 1, hour, minute);
    }
  } catch (e) {
  
  }
  return null;
}


String _formatTime(DateTime time) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  return "${twoDigits(time.hour)}:${twoDigits(time.minute)}";
}


  void clearAllTasks() {
    tasks.clear();
}



}
