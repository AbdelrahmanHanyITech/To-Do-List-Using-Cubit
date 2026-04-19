import 'package:flutter_bloc/flutter_bloc.dart';

class TodoCubit extends Cubit<List<String>> {
  TodoCubit() : super(const []);
  void addTask(String task) {
    if (task.trim().isEmpty) return;
    emit([...state, task.trim()]);
  }

  void removeTask(int index) {
    final updated = List<String>.from(state)..removeAt(index);
    emit(updated);
  }
}
