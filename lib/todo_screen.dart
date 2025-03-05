import 'package:flutter/material.dart';
import 'package:my_todo_list/widgets/new_todo.dart';
import 'package:my_todo_list/widgets/todo_list/todo_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_todo_list/widgets/add_button.dart';
import 'package:my_todo_list/models/todo.dart';
import 'package:my_todo_list/widgets/new_todo_assistant.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_todo_list/widgets/empty_list.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final bool _pinned = true;
  final bool _snap = false;
  final bool _floating = false;
  late Box<Todo> _todoBox;

  @override
  void initState() {
    super.initState();
    _todoBox = Hive.box<Todo>('todoListBox');
  }

  void _addTodo(Todo todo) async {
    await _todoBox.put(todo.id, todo);
  }

  void _addTodoAssistant(List<Todo> todos) async {
    for (var todo in todos) {
      await _todoBox.put(todo.id, todo);
    }
  }

  void _openAddTodoOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewTodo(onAddTodo: _addTodo),
    );
  }

  void _openAddTodoAssistantOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewTodoAssistant(onAddTodo: _addTodoAssistant),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: _todoBox.listenable(),
        builder:
            (context, todosBoxList, child) => CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: _pinned,
                  snap: _snap,
                  floating: _floating,
                  expandedHeight: 200,
                  backgroundColor: Color.fromARGB(255, 74, 55, 128),
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      'My Todo List',
                      style: GoogleFonts.chewy(
                        textStyle: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    centerTitle: true,
                    background: Image.asset(
                      'assets/images/header.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (todosBoxList.isEmpty)
                  SliverToBoxAdapter(child: EmptyList()),
                if (todosBoxList.isNotEmpty) TodoList(),
                if (todosBoxList.isNotEmpty) TodoList(isDone: true),
                SliverPadding(padding: EdgeInsets.only(bottom: 80)),
              ],
            ),
      ),
      floatingActionButton: AddButton(
        onNewItem: () {
          _openAddTodoOverlay();
        },
        onUseAssistant: () {
          _openAddTodoAssistantOverlay();
        },
        onClearAll: () {
          _todoBox.clear();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
