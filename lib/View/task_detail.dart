import 'package:flutter/material.dart';
import '/Model/task_model.dart';

class TaskDetailPage extends StatefulWidget {
  final Task task;

  const TaskDetailPage({super.key, required this.task});

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  late TimeOfDay startTime;
  late TimeOfDay endTime;
  late Duration taskDuration;

  @override
  void initState() {
    super.initState();

    //saat verisi eksikse 00 atıyorum
    if (!_isValidTimeFormat(widget.task.time.value)) {
      startTime = const TimeOfDay(hour: 0, minute: 0);
      endTime = const TimeOfDay(hour: 0, minute: 0);
      taskDuration = const Duration();
    } else {
      final times = widget.task.time.value.split('-');
      startTime = _parseTimeOfDay(times[0]);
      endTime = _parseTimeOfDay(times[1]);
      taskDuration = _durationBetween(startTime, endTime);
      //Bir görevin süresi sabittir diye varsayarak sadece başlangıç saatibi
      //değiştirilebilir yapmak istedim. Bitiş saati otomatik belirlencek
    }
  }

  bool _isValidTimeFormat(String value) {
    final regex = RegExp(r'^\d{2}:\d{2}-\d{2}:\d{2}$');
    return regex.hasMatch(value);
  }

  TimeOfDay _parseTimeOfDay(String timeStr) {
    try {
      final parts = timeStr.split(':');
      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    } catch (e) {
      return const TimeOfDay(hour: 0, minute: 0);
    }
  }

  Duration _durationBetween(TimeOfDay start, TimeOfDay end) {
    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;
    return Duration(minutes: endMinutes - startMinutes);
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    return "$h:$m";
  }

  void _updateTypeByStartTime() {
    if (startTime.hour > 6 && startTime.hour < 15) {
      widget.task.type.value = "Morning";
    } else {
      widget.task.type.value = "Night";
    }
  }

  Future<void> _selectStartTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: startTime,
    );

    if (picked != null && picked != startTime) {
      setState(() {
        startTime = picked;
        final newEndMinutes = startTime.hour * 60 + startTime.minute + taskDuration.inMinutes;
        final newEndHour = (newEndMinutes ~/ 60) % 24;
        final newEndMinute = newEndMinutes % 60;
        endTime = TimeOfDay(hour: newEndHour, minute: newEndMinute);


        widget.task.time.value = "${_formatTimeOfDay(startTime)}-${_formatTimeOfDay(endTime)}";

 
        _updateTypeByStartTime();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Görev Detayı')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${widget.task.id.value}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Adı: ${widget.task.name.value}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Tipi: ${widget.task.type.value}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Başlangıç Saati: ', style: TextStyle(fontSize: 18)),
                TextButton(
                  onPressed: _isValidTimeFormat(widget.task.time.value) ? _selectStartTime : null,
                  child: Text(
                    _formatTimeOfDay(startTime),
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            Text('Bitiş Saati: ${_formatTimeOfDay(endTime)}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
