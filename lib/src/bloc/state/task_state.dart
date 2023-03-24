import '../../model/task.dart';

abstract class TaskState {
  final List<Task> tasks;

  const TaskState({
    required this.tasks,
  });
}

class TasksInitialState extends TaskState {
  const TasksInitialState() : super(tasks: const []);
}

class TasksSuccessState extends TaskState {
  const TasksSuccessState({
    required List<Task> tasks,
  }) : super(tasks: tasks);
}

class TasksEmptyState extends TaskState {
  const TasksEmptyState() : super(tasks: const []);
}
