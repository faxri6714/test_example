import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_example/locator.dart';
import 'package:test_example/providers/completed_todo_provider.dart';
import 'package:test_example/providers/todo_provider.dart';

import 'screens/home_screen.dart';

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  late TodoProvider todoProvider;
  late CompletedTodoProvider completedTodoProvider;

  @override
  void initState() {
    todoProvider = locator();
    completedTodoProvider = locator();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: todoProvider),
        ChangeNotifierProvider.value(value: completedTodoProvider),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
