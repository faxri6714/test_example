class TodoEntity {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final bool isDone;
  final DateTime updateAt;

  TodoEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.isDone,
    required this.updateAt,
  });

  factory TodoEntity.empty() {
    return TodoEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: "",
      description: "",
      createdAt: DateTime.now(),
      updateAt: DateTime.now(),
      isDone: false,

    );
  }

  TodoEntity copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    bool? isDone,
  }) {
    return TodoEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      isDone: isDone ?? this.isDone,
      updateAt: DateTime.now(),
    );
  }

  @override
  String toString() {
    return """\n
    id : $id
    title : $title
    description : $description
    createdAt : $createdAt
    updateAt : $updateAt
    isDone : $isDone
    """;
  }
}
