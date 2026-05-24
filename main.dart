import 'db.dart';
import 'report.dart';
import 'task.dart';

final db = DB();

void main() {
  final report = Report(
    taskList: db.taskData.map((taskMap) => Task.fromMap(taskMap)).toList(),
  );

  //report.showAllTasks();
  // report.showTasksByStatus();
  // report.showAllStatus();
  // report.showTotalHoursByStatus();
  report.showTasksWithMissingFields();
}
