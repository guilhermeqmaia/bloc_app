import 'dart:math';

import 'package:bloc_todo_app/src/bloc/event/task_event.dart';
import 'package:bloc_todo_app/src/bloc/task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/state/task_state.dart';
import '../model/task.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  late final TaskBlock bloc;

  @override
  void initState() {
    super.initState();
    bloc = TaskBlock();
    bloc.add(LoadTasksEvent());
  }

  Task getRandomTask() {
    final tasks = [
      Task(title: 'Ir a academia', description: 'Treinar durante 40 minutos'),
      Task(
          title: 'Comer salada',
          description:
              'Pelo menos em uma refeição, metade do prato deve ser salada'),
      Task(title: 'Ler', description: 'Ler no mínimo 15 páginas'),
      Task(title: 'Meditar', description: 'Por no mínimo 10 minutos'),
      Task(
          title: 'Estudar',
          description:
              'Procurar um tópico da faculdade e estudar por no mínimo 2 horas'),
    ];
    final int randomTask = Random().nextInt(4);
    return tasks[randomTask];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: BlocBuilder<TaskBlock, TaskState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is TasksInitialState) {
              return Container(
                color: Colors.grey.shade100,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is TasksEmptyState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 50,
                    child: Text(
                      "Ops!",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Você está sem nenhuma tarefa pendente.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Para adicionar uma nova tarefa clique em Adicionar Task.',
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            } else if (state is TasksSuccessState) {
              if(state.tasks.isEmpty) {
                bloc.add(EmptyTasksEvent());
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        final Task task = state.tasks[index];
                        return ListTile(
                          title: Text(task.title),
                          subtitle: Text(task.description),
                          trailing: IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              bloc.add(RemoveTaskEvent(task: task));
                            },
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Column(
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Divider(),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          bloc.add(AddTaskEvent(task: getRandomTask()));
        },
        label: const Text('Adicionar Task'),
      ),
    );
  }
}
