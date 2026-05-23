import 'db.dart';
import 'task.dart';

final db = DB();

void main() {
  List<Task> taskList = db.taskData.map((e) => Task.fromMap(e)).toList();

  taskList.forEach(print);
}
