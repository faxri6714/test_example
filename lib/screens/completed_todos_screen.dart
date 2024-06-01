import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_example/providers/completed_todo_provider.dart';
import 'package:test_example/widgets/todo_card_widget.dart';

import '../core/entities/todo_entity.dart';

class CompletedTodosScreen extends StatefulWidget {
  const CompletedTodosScreen({Key? key}) : super(key: key);

  @override
  State<CompletedTodosScreen> createState() => _CompletedTodosScreenState();
}

class _CompletedTodosScreenState extends State<CompletedTodosScreen> {

  final List<TodoEntity> listTodoForDelete = [];

  @override
  void initState() {
    context.read<CompletedTodoProvider>().getListTodo();

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade700,
        leading: const BackButton(
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              context.read<CompletedTodoProvider>().clear();
            },
            icon: const Icon(Icons.delete_forever, color: Colors.white),
          ),
        ],
        title: const Text(
          'Completed Todo list',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<CompletedTodoProvider>().getListTodo();
           },
          child: ListView.separated(
            itemCount: context.watch<CompletedTodoProvider>().todo.length,
            itemBuilder: (context, index) {
              final todo = context.watch<CompletedTodoProvider>().todo[index];

              return AbsorbPointer(
                child: TodoCardWidget(
                  entity: todo,
                  isMenuActive: false,
                  onDelete: () async {},
                  onEdited: () async {},
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 10),
          ),
        ),
      ),
    );
  }
}
