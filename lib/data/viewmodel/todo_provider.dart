import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_riverpod_mvvm/data/model/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodoNotifier extends StateNotifier<List<TodoModel>> {
  TodoNotifier() : super([]);

  void create(TodoModel todo) {
    todo.id = const Uuid().v4();
    todo.createdAt = DateTime.now();
    state = [...state, todo];
  }

  void removeTodo(String todoId) {
    state = state.where((item) => item.id != todoId).toList();
  }

  void editTask(TodoModel updataTodo) {
    state = [
      for (var todo in state)
        if (todo.id == updataTodo.id) updataTodo else todo
    ];
  }
}

final todoProvider = StateNotifierProvider<TodoNotifier, List<TodoModel>>(
  (ref) {
    return TodoNotifier();
  },
);
