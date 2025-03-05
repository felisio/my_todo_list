import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import 'package:hive/hive.dart';
import 'category.dart';

part 'todo.g.dart';

final formatter = DateFormat('MM/dd/yyyy hh:mm aaa');
const uuid = Uuid();

@HiveType(typeId: 0)
class Todo {
  Todo({
    required this.id,
    required this.title,
    this.isDone = false,
    required this.category,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final bool isDone;
  @HiveField(3)
  final DateTime createdAt;
  @HiveField(4)
  final Category category;

  String get formattedDate => formatter.format(createdAt);

  factory Todo.create({required String title, required Category category}) {
    return Todo(
      id: uuid.v4(),
      title: title,
      category: category,
      createdAt: DateTime.now(),
      isDone: false,
    );
  }

  Todo copyWith({
    String? title,
    Category? category,
    bool? isDone,
    DateTime? createdAt,
  }) {
    return Todo(
      id: id,
      title: title ?? this.title,
      category: category ?? this.category,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
