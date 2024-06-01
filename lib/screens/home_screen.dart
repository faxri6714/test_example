import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_example/providers/completed_todo_provider.dart';
import 'package:test_example/providers/todo_provider.dart';
import 'package:test_example/screens/completed_todos_screen.dart';
import 'package:test_example/screens/create_todo_screen.dart';
import 'package:test_example/widgets/text_field_widget.dart';
import 'package:test_example/widgets/todo_card_widget.dart';

import '../core/entities/todo_entity.dart';
import '../core/utils/storage_boxes.dart';
import '../locator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controllerSearch = TextEditingController();

  @override
  void initState() {
    context.read<TodoProvider>().getListTodo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade700,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreateTodoScreen(
                    onAdd: (TodoEntity entity) {
                      // listTodo.add(entity);
                      // setState(() {});
                    },
                  ),
                ),
              );
            },
            icon: const Icon(Icons.add, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CompletedTodosScreen(),
                ),
              );
            },
            icon: const Icon(Icons.done, color: Colors.white),
          ),
        ],
        title: const Text(
          'Todo list',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            TextFormFieldWidget(
              controller: controllerSearch,
              onChange: (search) async {
                 context.read<TodoProvider>().search(search!);

              },
              hintText: "Search",
            ),
            const SizedBox(height: 10),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<TodoProvider>().getListTodo();
                },
                child: ListView.separated(
                  itemCount: context.watch<TodoProvider>().todo.length,
                  itemBuilder: (context, index) {
                    final todo = context.watch<TodoProvider>().todo[index];

                    return TodoCardWidget(
                      entity: todo,
                      onDone: () async {
                        context
                            .read<CompletedTodoProvider>()
                            .marcTodoCompletetd(todo);
                        context.read<TodoProvider>().remove(todo);
                      },
                      onDelete: () async {
                        context.read<TodoProvider>().remove(todo);
                      },
                      onEdited: () async {
                        await context.read<TodoProvider>().getListTodo();
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
