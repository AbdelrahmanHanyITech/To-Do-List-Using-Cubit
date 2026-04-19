import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/todo_cubit.dart';

class TodoPage extends StatelessWidget {
  TodoPage({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Todo Cubit')),

        body: Column(
          children: [
            // --------------------- INPUT --------------------- 
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

                  // Add Button
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

            // --------------------- LIST ---------------------
            Expanded(
              child: BlocBuilder<TodoCubit, List<Task>>(
                builder: (context, tasks) {
                  if (tasks.isEmpty) {
                    return const Center(child: Text('No tasks yet'));
                  }

                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];

                      return ListTile(
                        // Checkbox 
                        leading: Checkbox(
                          value: task.isDone,
                          onChanged: (_) {
                            context.read<TodoCubit>().toggleTask(index);
                          },
                        ),

                        // Task Title
                        title: Text(
                          task.title,
                          style: TextStyle(
                            decoration: task.isDone
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),

                        // Delete
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context.read<TodoCubit>().removeTask(index);
                          },
                        ),

                        // Edit on tap
                        onTap: () {
                          controller.text = task.title;

                          showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: const Text('Edit Task'),
                                content: TextField(controller: controller),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      context.read<TodoCubit>().editTask(
                                        index,
                                        controller.text,
                                      );

                                      controller.clear();
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Save'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
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
