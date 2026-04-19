import 'package:flutter_bloc/flutter_bloc.dart';

// Model representing a single task in the todo list
class Task {
  String title;
  bool isDone;

  Task({required this.title, this.isDone = false});
}

// Cubit managing the state of the todo list, which is a list of tasks
class TodoCubit extends Cubit<List<Task>> {
  TodoCubit() : super([]);

  //  Add Task
  void addTask(String task) {
    if (task.trim().isEmpty) return;

    emit([
      ...state,
      Task(title: task.trim()), // Add new task to the existing list
    ]);
  }

  // Remove Task
  void removeTask(int index) {
    final updated = List<Task>.from(state)..removeAt(index);
    emit(updated);
  }

  // Toggle Checkbox (complete / uncomplete )
  void toggleTask(int index) {
    final updated = List<Task>.from(state);

    updated[index].isDone = !updated[index].isDone;

    emit(updated);
  }

  // Edit Task
  void editTask(int index, String newTitle) {
    if (newTitle.trim().isEmpty) return;

    final updated = List<Task>.from(state);

    updated[index].title = newTitle.trim();

    emit(updated);
  }
}
