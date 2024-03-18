import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_riverpod_mvvm/data/model/todo_model.dart';
import 'package:flutter_todo_riverpod_mvvm/data/viewmodel/todo_provider.dart';
import 'package:flutter_todo_riverpod_mvvm/widgets/todo_card.dart';

class TodoHomepage extends ConsumerWidget {
  void openDialog(BuildContext context, WidgetRef ref) {
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
                  child: Text("New Todo"),
                ),
                TextFormField(controller: titleController),
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
                            ref.read(todoProvider.notifier).create(TodoModel(
                                  title: titleController.text,
                                  desc: descController.text,
                                ));
                            titleController.clear();
                            descController.clear();
                            Navigator.pop(context);
                          },
                          child: const Text("Create ")),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Close ")),
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
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(todoProvider);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO FLUTTER APP"),
      ),
      body: ListView.builder(
        itemCount: todoData.length,
        itemBuilder: (context, index) =>
            TodoCard(ref: ref, todo: todoData[index]),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          openDialog(context, ref);
        },
      ),
    );
  }
}
