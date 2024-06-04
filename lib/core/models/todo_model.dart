import '../entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  TodoModel({
    required super.id,
    required super.title,
    required super.description,
    required super.createdAt,
    required super.isDone,
    required super.updateAt,
  });

  factory TodoModel.fromEntity(TodoEntity entity) {
    return TodoModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      createdAt: entity.createdAt,
      isDone: entity.isDone,
      updateAt: entity.updateAt,
    );
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      updateAt: DateTime.parse(json['updateAt']),
      isDone: json['isDone'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['createdAt'] = createdAt.toString();
    data['updateAt'] = updateAt.toString();
    data['isDone'] = isDone;


    return data;
  }
}
