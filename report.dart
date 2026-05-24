import 'task.dart';

typedef MapTaskByStaus = Map<String, List<Task>>;

class Report {
  List<Task> taskList;
  Report({required this.taskList});

  MapTaskByStaus _getTasksByStatus() {
    MapTaskByStaus map = {
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

  Map<String, int> _getTotalHoursByStatus(MapTaskByStaus tasks) {
    return {
      "concluida": tasks["completed"]!.fold(
        0,
        (value, task) => value + task.hours,
      ),
      "em andamento": tasks["ongoing"]!.fold(
        0,
        (value, task) => value + task.hours,
      ),
      "pendente": tasks["pending"]!.fold(
        0,
        (value, task) => value + task.hours,
      ),
      "cancelada": tasks["canceled"]!.fold(
        0,
        (value, task) => value + task.hours,
      ),
    };
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

  void showTotalHoursByStatus() {
    print("Horas por status:");
    _getTotalHoursByStatus(_getTasksByStatus()).forEach((key, value) {
      print(" - $key: $value horas");
    });
  }

  void showTasksWithMissingFields() {
    final incompleteTasks = taskList.whereType<IncompleteTask>().toList();

    print("Tarefas com dados incompletos:");
    for (var task in incompleteTasks) {
      task.missingFields = task.missingFields
          .map((e) => "$e faltando")
          .toList();

      print(" - ID ${task.id}: ${task.missingFields.join(" ou ")}");
    }
  }
}
