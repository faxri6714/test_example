import 'package:flutter/widgets.dart';
import 'package:test_example/core/entities/todo_entity.dart';
import 'package:test_example/core/utils/storage_boxes.dart';
import 'package:test_example/core/utils/todo_storage_service.dart';

class TodoProvider extends ChangeNotifier{
 late TodoStorageService service;

 TodoProvider(this.service);

 List<TodoEntity> _todos = [];
 List<TodoEntity> get todo => _todos;

 addTodo(TodoEntity todo)async{
   await service.save(todo);
   _todos.add(todo);
   notifyListeners();
 }

 remove(TodoEntity todo )async{
   await service.deleteTodo(todo , StorageBoxes.todos);
   _todos.remove(todo);
   notifyListeners();
 }

 updateTodo(TodoEntity todo) async{
 await service.updateTodo(todo);
 final index = _todos.indexWhere((element) => element.id == todo.id);

 _todos[index] = todo;
 notifyListeners();
 }

Future<void> getListTodo() async{
   final data =  await service.getListTodo(boxName: StorageBoxes.todos);
 _todos = data;
 }
 Future<List<TodoEntity>> getListCompletedTodo() async{
   return await service.getListTodo(boxName: StorageBoxes.completedTodos);
 }

 search(String? value){
   if (value == null || value.isEmpty) {
     getListTodo();
   }
   final List<TodoEntity> datas = todo.where(
         (element) {
       return element.title
           .toLowerCase()
           .contains(value!.toLowerCase());
     },
   ).toList();

   _todos = datas;
   notifyListeners();
 }
 deleteAll() async{
  await service.deleteAll();
 }

}

