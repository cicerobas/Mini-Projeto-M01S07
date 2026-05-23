class Task {
  int id;
  String title;
  String assignee;
  String status;
  String priority;
  double value;
  int hours;

  Task({
    required this.id,
    required this.title,
    required this.assignee,
    required this.status,
    required this.priority,
    required this.value,
    required this.hours,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    List<String> missingFields = [];

    map.forEach((key, value) {
      if (value == null) {
        missingFields.add(key);
      }
    });

    String title = map["titulo"] == null
        ? "Sem título"
        : map["titulo"].toString().trim();

    String assignee = map["responsavel"] == null
        ? "Não informado"
        : map["responsavel"].toString().trim();

    String status = map["status"] == null
        ? "Sem status"
        : map["status"].toString().trim();

    String priority = map["prioridade"] == null
        ? "Sem prioridade"
        : map["prioridade"].toString().trim();

    double value =
        double.tryParse(
          map["valor"]
                  ?.toString()
                  .replaceAll('R\$', '')
                  .replaceAll(',', '.')
                  .trim() ??
              '',
        ) ??
        0.0;

    int hours = int.tryParse(map["horas"]?.toString() ?? '') ?? 0;

    if (missingFields.isNotEmpty) {
      return IncompleteTask(
        id: map["id"],
        title: title,
        assignee: assignee,
        status: status,
        priority: priority,
        value: value,
        hours: hours,
        missingFields: missingFields,
      );
    }

    return Task(
      id: map["id"],
      title: title,
      assignee: assignee,
      status: status,
      priority: priority,
      value: value,
      hours: hours,
    );
  }

  @override
  String toString() {
    return 'Task(id: $id, title: $title, assignee: $assignee, status: $status, priority: $priority, value: $value, hours: $hours)';
  }
}

class IncompleteTask extends Task {
  List<String> missingFields;

  IncompleteTask({
    required super.id,
    required super.title,
    required super.assignee,
    required super.status,
    required super.priority,
    required super.value,
    required super.hours,
    required this.missingFields,
  });

  @override
  String toString() {
    return super.toString();
  }
}
