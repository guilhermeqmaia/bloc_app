import '../model/task.dart';

class TaskRepository {
  final List<Task> _todoList = [];

  List<Task> fetch() {
    return _todoList;
  }

  List<Task> addTask(Task task) {
    _todoList.add(task);
    return _todoList;
  }

  List<Task> removeTask(Task task) {
    _todoList.remove(task);
    return _todoList;
  }
}
