import 'package:flutter/cupertino.dart';

import '../core/entities/todo_entity.dart';
import '../core/utils/storage_boxes.dart';
import '../core/utils/todo_storage_service.dart';

class CompletedTodoProvider extends ChangeNotifier{
  late TodoStorageService service;

  CompletedTodoProvider(this.service);

  List<TodoEntity> _todos = [];
  List<TodoEntity> get todo => _todos;

marcTodoCompletetd(TodoEntity todo)async{
  final completedTodo = todo.copyWith(isDone: true);

  await service.save(completedTodo,boxName: StorageBoxes.completedTodos);
}


deleteListTodo(List<TodoEntity> todos)async{
  await service.deleteTodos(todos, StorageBoxes.completedTodos);
  _todos.clear();
  notifyListeners();
}
  Future<void> getListTodo() async{
    final data =  await service.getListTodo(boxName: StorageBoxes.completedTodos);
    _todos = data;
    notifyListeners();
  }


clear()async{
  await service.deleteTodos(_todos, StorageBoxes.completedTodos);
  _todos.clear();
  notifyListeners();
}

}