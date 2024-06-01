

import 'package:get_it/get_it.dart';
import 'package:test_example/providers/completed_todo_provider.dart';
import 'package:test_example/providers/todo_provider.dart';

import 'core/utils/todo_storage_service.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerSingleton(TodoStorageService());
  locator.registerSingleton(TodoProvider(locator()));
  locator.registerSingleton(CompletedTodoProvider(locator()));
}
