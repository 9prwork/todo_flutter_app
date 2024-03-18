import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_riverpod_mvvm/data/model/todo_model.dart';
import 'package:flutter_todo_riverpod_mvvm/data/viewmodel/todo_provider.dart';

class TodoCard extends StatelessWidget {
  final WidgetRef ref;
  final TodoModel todo;
  const TodoCard({super.key, required this.ref, required this.todo});

  void openEditDialog(BuildContext context, WidgetRef ref) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  child: Text("Edit Task"),
                ),
                TextFormField(
                  controller: titleController,
                ),
                TextFormField(
                  controller: descController,
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            ref.read(todoProvider.notifier).editTask(TodoModel(
                                id: todo.id,
                                title: titleController.text,
                                desc: descController.text,
                                createdAt: todo.createdAt));
                            titleController.clear();
                            descController.clear();
                            Navigator.pop(context);
                          },
                          child: const Text("Edit")),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel")),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Title : ${todo.title}}"),
                  Text("Description : ${todo.desc}"),
                  Text("Time : ${todo.createdAt}"),
                ],
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton(
                  icon: const Icon(Icons.more_horiz),
                  items: const [
                    DropdownMenuItem(
                      child: Text("Edit"),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text("Delete"),
                      value: 2,
                    ),
                  ],
                  onChanged: (value) {
                    if (value == 1) {
                      openEditDialog(context, ref);
                    } else if (value == 2) {
                      ref.read(todoProvider.notifier).removeTodo(todo.id!);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
