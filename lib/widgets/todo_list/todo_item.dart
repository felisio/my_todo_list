import 'package:flutter/material.dart';
import 'package:my_todo_list/models/todo.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_todo_list/models/category.dart';
import 'package:hive/hive.dart';

class TodoItem extends StatefulWidget {
  const TodoItem({super.key, required this.todo, required this.index});

  final Todo todo;
  final int index;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late Box<Todo> _todoBox;

  @override
  void initState() {
    super.initState();
    _todoBox = Hive.box<Todo>('todoListBox');
  }

  void _toggleTodo(bool value) async {
    final int duration = value ? 400 : 0;
    Future.delayed(Duration(milliseconds: duration), () async {
      Todo todo = widget.todo;
      final updateTodo = todo.copyWith(isDone: value);
      await _todoBox.put(updateTodo.id, updateTodo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color:
                    widget.todo.isDone
                        ? Colors.grey
                        : categoryColors[widget.todo.category],
                shape: BoxShape.circle,
              ),
              child: Icon(
                categoryIcons[widget.todo.category],
                color:
                    widget.todo.isDone
                        ? const Color.fromARGB(255, 104, 103, 103)
                        : Color.fromARGB(255, 74, 55, 128),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.todo.title,
                    style: GoogleFonts.chewy(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      decoration:
                          widget.todo.isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                      color:
                          widget.todo.isDone
                              ? Colors.grey
                              : Color.fromARGB(255, 74, 55, 128),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.todo.formattedDate,
                    style: GoogleFonts.chewy(
                      fontSize: 13,
                      color:
                          widget.todo.isDone
                              ? Colors.grey
                              : Color.fromARGB(255, 122, 55, 128),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              iconSize: 32,
              icon: Icon(
                widget.todo.isDone ? Icons.check_circle : Icons.circle_outlined,
                color: widget.todo.isDone ? Colors.green : Colors.grey,
              ),
              onPressed: () => _toggleTodo(!widget.todo.isDone),
            ),
          ],
        ),
      ),
    );
  }
}
