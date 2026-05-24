import 'task.dart';

typedef MapTaskByStaus = Map<String, List<Task>>;

class Report {
  List<Task> taskList;
  Report({required this.taskList});

  // Cria um Map separando a lista por cada status
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

  // Utiliza o Map filtrado por status para somar as horas
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
      tasks.forEach((task) => print(" - ID ${task.id}: ${task.title}"));
    });
  }

  void showAllStatus() {
    print("\nStatus encontrados:");
    _getStatusSet().forEach((status) => print(" - $status"));
  }

  void showTotalHoursByStatus() {
    print("\nHoras por status:");
    _getTotalHoursByStatus(_getTasksByStatus()).forEach((key, value) {
      print(" - $key: $value horas");
    });
  }

  void showTasksWithMissingFields() {
    // Usa whereType() na lista para filtrar e fazer o cast pelo tipo
    final incompleteTasks = taskList.whereType<IncompleteTask>().toList();

    print("\nTarefas com dados incompletos:");
    for (var task in incompleteTasks) {
      task.missingFields = task.missingFields
          .map((e) => "$e faltando")
          .toList();

      print(" - ID ${task.id}: ${task.missingFields.join(" ou ")}");
    }
  }

  void showCompleteReport() {
    final filteredTasks = _getTasksByStatus();

    print("${' ' * 12}RELATÓRIO FINAL DE TAREFAS${' ' * 12}");
    print("${'#' * 17} LISTA COMPLETA ${'#' * 17}");
    showAllTasks();

    print("\n${'#' * 14} FILTRADAS POR STATUS ${'#' * 14}");
    showTasksByStatus();

    print("\n${'#' * 20} DETALHES ${'#' * 20}");
    print("\nTotal de tarefas analisadas: ${taskList.length}");
    print("Tarefas concluídas: ${filteredTasks['completed']?.length ?? 0}");
    print("Tarefas pendentes: ${filteredTasks['pending']?.length ?? 0}");
    print("Tarefas em andamento: ${filteredTasks['ongoing']?.length ?? 0}");
    print("Tarefas canceladas: ${filteredTasks['canceled']?.length ?? 0}");

    showAllStatus();

    final completedTasks = filteredTasks['completed'];
    print(
      "\nValor total das concluídas: R\$ ${_getCompletedTasksValue(completedTasks ?? [])}",
    );

    final pendingTasks = filteredTasks['pending'];
    print(
      (pendingTasks ?? []).isEmpty
          ? "Não existem tarefas pendentes para calcular média."
          : "Média de valor das pendentes: R\$ ${_getPendingTasksAverageValue(pendingTasks ?? [])}",
    );

    showTotalHoursByStatus();

    showTasksWithMissingFields();
  }
}
