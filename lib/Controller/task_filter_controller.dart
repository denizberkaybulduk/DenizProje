import 'package:get/get.dart';
import '/Model/task_model.dart';
import 'task_controller2.dart';

// Bozuk data yakaldığında sadece bozuk datada error göster elindeki data gözüksün.
// data yokken aşağıda butonlar olmasın 
// her 5 snde bir datayı refleshle, Controller'da yap. FetchController() 
// Task Sayfasında veri girişi ve type info gözüksün. Task seçildiğinde detay sayfasına gitsin. ok
// Detay sayfasında dakikayı saat olarak editeyebildiğimiz yapı. (Pop up olacak )
// Gruplama mekanizması Selectable şekilde
// routelama yap 



enum GroupByOption { none, name, type }

class TaskFilterController extends GetxController {
  final TaskController taskController = Get.find<TaskController>();

  var selectedGroupBy = GroupByOption.none.obs;

  // none - filtre seçilmemiş

  var groupedTasks = <String, List<Task>>{}.obs;

  
  var errorTasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();

    ever(selectedGroupBy, (_) => groupTasks());
    ever(taskController.tasks, (_) => groupTasks());

    groupTasks();
    // ilk gösterim
  }

  void groupTasks() {
    final groupBy = selectedGroupBy.value;
    final allTasks = taskController.tasks;

    
    errorTasks.value = allTasks.where((t) => t.isError.value).toList();

  
    final filteredTasks = allTasks.where((t) => !t.isError.value).toList();
    // hatasızları topladık

    if (groupBy == GroupByOption.none) {
      groupedTasks.value = {'Tüm Görevler': filteredTasks};
    } else {
      final Map<String, List<Task>> map = {};
      for (var task in filteredTasks) {
        String key = '';
        if (groupBy == GroupByOption.name) {
          key = task.name.value;
        } else if (groupBy == GroupByOption.type) {
          key = task.type.value;
        }

        if (!map.containsKey(key)) {
          map[key] = [];
          // o key yoksa oluşturduk ve boş liste oluşturduk onun için
        }
        map[key]!.add(task);
      }
      groupedTasks.value = map;
    }
  }

  void setGroupBy(GroupByOption option) {
    selectedGroupBy.value = option;
  }
  //viewda kullanmak için
}
