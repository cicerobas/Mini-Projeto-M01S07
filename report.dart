import 'task.dart';

class Report {
  List<Task> taskList;
  Report({required this.taskList});

  Map<String, List<String>> _getTasksByStatus() {
    Map<String, List<String>> map = {
      "completed": [],
      "ongoing": [],
      "pending": [],
      "canceled": [],
    };

    for (var task in taskList) {
      switch (task.status) {
        case "concluida":
          map["completed"]!.add(task.title);
          break;
        case "em andamento":
          map["ongoing"]!.add(task.title);
          break;
        case "pendente":
          map["pending"]!.add(task.title);
          break;
        case "cancelada":
          map["canceled"]!.add(task.title);
          break;
      }
    }
    return map;
  }

  Set<String> _getStatusSet() => taskList.map((task) => task.status).toSet();

  void showAllTasks() => taskList.forEach(print);

  void showTasksByStatus() {
    _getTasksByStatus().forEach((key, value) {
      print(switch (key) {
        "completed" => "\nTarefas concluídas:",
        "ongoing" => "\nTarefas em andamento:",
        "pending" => "\nTarefas pendentes:",
        "canceled" => "\nTarefas canceladas:",
        _ => "",
      });
      value.forEach((e) => print(" - $e"));
    });
  }

  void showAllStatus() {
    print("Status encontrados:");
    _getStatusSet().forEach((status) => print(" - $status"));
  }
}
