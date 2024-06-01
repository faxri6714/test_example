import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_example/providers/todo_provider.dart';
import 'package:test_example/widgets/text_field_widget.dart';

import '../core/entities/todo_entity.dart';
import '../core/utils/todo_storage_service.dart';
import '../locator.dart';

class EditTodoScreen extends StatefulWidget {
  final TodoEntity entity;
  final Function() onEdited;
  const EditTodoScreen({Key? key, required this.entity, required this.onEdited}) : super(key: key);

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  final TextEditingController controllerTitle = TextEditingController();
  final TextEditingController controllerDescription = TextEditingController();

  TodoEntity entity = TodoEntity.empty();

  @override
  void initState() {

    entity = widget.entity;
    controllerTitle.text = entity.title;
    controllerDescription.text = entity.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: Colors.blueGrey.shade700,
        title: Text(
          'Edit Todo ${entity.id}',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextFormFieldWidget(
              controller: controllerTitle,
              hintText: "Title",
              onChange: (value) {
                value = value.toString().substring(0,1).toUpperCase() + value.toString().substring(1,value.toString().length).toLowerCase();

                entity = entity.copyWith(title: value);
              },
            ),
            const SizedBox(height: 20),
            TextFormFieldWidget(
              controller: controllerDescription,
              hintText: "Descriptions",
              onChange: (value) {
                value = value.toString().substring(0,1).toUpperCase() + value.toString().substring(1,value.toString().length).toLowerCase();

                entity = entity.copyWith(description: value);
              },
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () async {

                  context.read<TodoProvider>().updateTodo(entity);
                    widget.onEdited.call();

                  Navigator.pop(context);

                }

                ,
                child: const Text(
                  "update",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
