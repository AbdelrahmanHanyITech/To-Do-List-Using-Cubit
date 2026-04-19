import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'todo_cubit.dart';

class TodoPage extends StatelessWidget {
  TodoPage({super.key});
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todo Cubit'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: 'Enter task',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Builder(
                    builder: (context) {
                      return ElevatedButton(
                        onPressed: () {
                          context.read<TodoCubit>().addTask(controller.text);
                          controller.clear();
                        },
                        child: const Text('Add'),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<TodoCubit, List<String>>(
                builder: (context, tasks) {
                  if (tasks.isEmpty) {
                    return const Center(
                      child: Text('No tasks yet'),
                    );
                  }
                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(tasks[index]),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context.read<TodoCubit>().removeTask(index);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}