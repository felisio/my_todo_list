import 'package:flutter/material.dart';
import 'package:my_todo_list/models/todo.dart';
import 'package:my_todo_list/widgets/todo_list/todo_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key, this.isDone = false});

  final bool isDone;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  late Box<Todo> _todoBox;

  void _removeTodoItem(Todo todo) {
    _todoBox.delete(todo.id);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text('Todo item deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _todoBox.put(todo.id, todo);
            });
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _todoBox = Hive.box<Todo>('todoListBox');
  }

  List<Todo> shuffledTodoList() {
    final List<Todo> shuffledTodoList = List.of(_todoBox.values.toList());
    shuffledTodoList.shuffle();
    return shuffledTodoList;
  }

  List<Todo> getTodoList() {
    return List.of(_todoBox.values.toList());
  }

  @override
  Widget build(BuildContext context) {
    var todos =
        widget.isDone
            ? getTodoList().where((todo) => todo.isDone).toList()
            : getTodoList().where((todo) => !todo.isDone).toList();

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Dismissible(
          key: ValueKey(todos[index]),
          onDismissed: (direction) {
            _removeTodoItem(todos[index]);
          },
          background: Container(
            color: Theme.of(context).colorScheme.error.withAlpha(75),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            child: Column(
              children: [
                if (widget.isDone && index == 0)
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'Completed',
                      style: GoogleFonts.chewy(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 74, 55, 128),
                      ),
                    ),
                  ),
                TodoItem(todo: todos[index], index: index),
              ],
            ),
          ),
        ),
        childCount: todos.length,
      ),
    );
  }
}
