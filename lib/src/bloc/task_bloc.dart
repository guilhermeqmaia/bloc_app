import 'package:bloc/bloc.dart';
import 'package:bloc_todo_app/src/bloc/event/task_event.dart';
import 'package:bloc_todo_app/src/bloc/state/task_state.dart';
import 'package:bloc_todo_app/src/datasource/task_repository.dart';

class TaskBlock extends Bloc<TaskEvent, TaskState> {
  final _repository = TaskRepository();

  TaskBlock() : super(const TasksInitialState()) {
    on<LoadTasksEvent>((event, emit) {
      final tasks = _repository.fetch();
      if (tasks.isEmpty) {
        emit(const TasksEmptyState());
      } else {
        emit(TasksSuccessState(tasks: tasks));
      }
    });

    on<AddTaskEvent>((event, emit) =>
        emit(TasksSuccessState(tasks: _repository.addTask(event.task))));

    on<RemoveTaskEvent>((event, emit) =>
        emit(TasksSuccessState(tasks: _repository.removeTask(event.task))));

    on<EmptyTasksEvent>((event, emit) => emit(const TasksEmptyState()));
  }
}
