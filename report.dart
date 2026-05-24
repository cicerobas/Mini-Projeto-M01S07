import 'task.dart';

class Report {
  List<Task> taskList;
  Report({required this.taskList});

  Map<String, List<Task>> _getTasksByStatus() {
    Map<String, List<Task>> map = {
      "completed": [],
      "ongoing": [],
      "pending": [],
      "canceled": [],
    };

    for (var task in taskList) {
      switch (task.status) {
        case "concluida":
          map["completed"]!.add(task);
          break;
        case "em andamento":
          map["ongoing"]!.add(task);
          break;
        case "pendente":
          map["pending"]!.add(task);
          break;
        case "cancelada":
          map["canceled"]!.add(task);
          break;
      }
    }
    return map;
  }

  Set<String> _getStatusSet() => taskList.map((task) => task.status).toSet();

  double _getCompletedTasksValue(List<Task> completedTasks) =>
      completedTasks.fold(0, (value, task) => value + task.value);

  double _getPendingTasksAverageValue(List<Task> pendingTasks) {
    double total = pendingTasks.fold(0, (value, task) => value + task.value);
    return total / pendingTasks.length;
  }

  void showAllTasks() => taskList.forEach(print);

  void showTasksByStatus() {
    _getTasksByStatus().forEach((key, tasks) {
      print(switch (key) {
        "completed" => "\nTarefas concluídas:",
        "ongoing" => "\nTarefas em andamento:",
        "pending" => "\nTarefas pendentes:",
        "canceled" => "\nTarefas canceladas:",
        _ => "",
      });
      tasks.forEach((task) => print(" - ${task.title}"));
    });
  }

  void showAllStatus() {
    print("Status encontrados:");
    _getStatusSet().forEach((status) => print(" - $status"));
  }
}
