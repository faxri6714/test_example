import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../entities/todo_entity.dart';
import '../models/todo_model.dart';
import 'storage_boxes.dart';



class TodoStorageService {
  save(TodoEntity entity, {String? boxName}) async {
    final box = await Hive.openBox(boxName ?? StorageBoxes.todos);

    final model = TodoModel.fromEntity(entity);
    debugPrint("Added data $model to box ${boxName ?? StorageBoxes.todos}");

    await box.add(model.toJson());
  }

  saveNewList(List<TodoEntity> listTodo) async {
    final box = await Hive.openBox(StorageBoxes.todos);

    await box.clear();

    final List<Map<String, dynamic>> listJson = listTodo
        .map((element) => TodoModel.fromEntity(element).toJson())
        .toList();

    debugPrint("Remove data from box ${StorageBoxes.todos} ${listJson.length}");

    await box.addAll(listJson);
  }

  Future<List<TodoEntity>> getListTodo({String? boxName}) async {
    final box = await Hive.openBox(boxName ?? StorageBoxes.todos);

    final listJson = List.from(box.values);

    final List<TodoEntity> listData = [];
    for (var json in listJson) {
      listData.add(TodoModel.fromJson(Map<String, dynamic>.from(json)));
    }

    debugPrint("List data ${listData.length}");

    return listData;
  }

  Future<void> updateTodo(TodoEntity entity) async {
    final listTodo = await getListTodo();

    final elementIndex =
        listTodo.indexWhere((element) => element.id == entity.id);

    listTodo[elementIndex] = entity;

    await saveNewList(listTodo);
  }

  deleteTodos(List<TodoEntity> data, String boxName) async {
    for (var element in data) {
      await deleteTodo(element, boxName);
    }
  }

  deleteTodo(TodoEntity entity, String boxName) async {
    final box = await Hive.openBox(boxName);

    final json = TodoModel.fromEntity(entity).toJson();

    final dataList = List.from(box.values);

    final itemIndex = dataList.indexWhere((element) {
      print(element.toString() == json.toString());
      return element.toString() == json.toString();
    });

    await box.deleteAt(itemIndex);
  }

  deleteDataFromBox(String boxName) async {
    final box = await Hive.openBox(boxName);

    await box.deleteFromDisk();
  }

  deleteAll() async {
    final boxTodo = await Hive.openBox(StorageBoxes.todos);
    final boxCompletedTodo = await Hive.openBox(StorageBoxes.completedTodos);

    await boxTodo.deleteFromDisk();
    await boxCompletedTodo.deleteFromDisk();
  }
}

