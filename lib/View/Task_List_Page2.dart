import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '/Controller/task_controller2.dart';
import '/Controller/task_filter_controller.dart';
import '/Controller/fetch_controller.dart';
import '/Model/task_model.dart';
import '/../routes.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    final taskController = Get.find<TaskController>();
    final filterController = Get.find<TaskFilterController>();
    final fetchController = Get.find<FetchController>();

    return VisibilityDetector(
      key: const Key("TaskListViewVisibility"),
      onVisibilityChanged: (info) {
        final visible = info.visibleFraction > 0;
        fetchController.setVisible(visible);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Task List"),
          actions: [
            Obx(() {
              return DropdownButton<GroupByOption>(
                value: filterController.selectedGroupBy.value,
                onChanged: (value) {
                  if (value != null) {
                    filterController.setGroupBy(value);
                  }
                },
                items: GroupByOption.values.map((option) {
                  return DropdownMenuItem<GroupByOption>(
                    value: option,
                    child: Text(
                      option == GroupByOption.none
                          ? "Filtre Yok"
                          : option == GroupByOption.name
                              ? "İsme Göre"
                              : "Tipe Göre",
                    ),
                  );
                }).toList(),
              );
            }),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(() {
                final groups = filterController.groupedTasks;
                final errorTasks = filterController.errorTasks;

                if (groups.isEmpty && errorTasks.isEmpty) {
                  return const Center(child: Text("Görev bulunamadı."));
                }

                return ListView(
                  children: [
                    ...groups.entries.expand((entry) {
                      final groupName = entry.key;
                      final taskList = entry.value;

                      return [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: Text(
                            groupName,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ...taskList
                            .map((task) => TaskTile(task: task))
                            .toList(),
                      ];
                    }),
                    if (errorTasks.isNotEmpty) ...[
                      const Divider(),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Text(
                          "Hatalı Görevler",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      ...errorTasks.map((task) =>
                          TaskTile(task: task, isError: true)),
                    ]
                  ],
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Obx(() {
                if (taskController.tasks.isEmpty) {
                  return const SizedBox.shrink();
                } else {
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: taskController.addThirtyMinutesToTimes,
                        child: const Text("30dk ekle"),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: taskController.clearAllTasks,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        child: const Text("Tüm Görevleri Sil"),
                      ),
                    ],
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskTile extends StatelessWidget {
  final Task task;
  final bool isError;

  const TaskTile({super.key, required this.task, this.isError = false});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.toNamed(AppRoutes.taskDetail, arguments: task);
      },
      title: Text(
        task.name.value.isEmpty ? "(İsim boş)" : task.name.value,
        style: TextStyle(color: isError ? Colors.red : Colors.black),
      ),
      subtitle: Text(
        task.type.value.isEmpty ? "(Tip boş)" : task.type.value,
        style: TextStyle(color: isError ? Colors.red : Colors.black),
      ),
    );
  }
}
