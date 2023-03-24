import '../../model/task.dart';

abstract class TaskEvent {}

class LoadTasksEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final Task task;

  AddTaskEvent({required this.task});
}

class RemoveTaskEvent extends TaskEvent {
  final Task task;

  RemoveTaskEvent({required this.task});
}

class EmptyTasksEvent extends TaskEvent {}
