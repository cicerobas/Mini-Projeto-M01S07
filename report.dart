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
