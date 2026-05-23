import 'task.dart';

class Report {
  List<Task> taskList;
  Report({required this.taskList});

  void showAllTasks() => taskList.forEach(print);
}
