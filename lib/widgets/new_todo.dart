import 'package:flutter/material.dart';
import 'package:my_todo_list/models/todo.dart';
import 'package:my_todo_list/models/category.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({super.key, required this.onAddTodo});

  final Function(Todo) onAddTodo;

  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  final _titleController = TextEditingController();
  Category _selectedCategory = Category.personal;

  void _submitTodoData() {
    final enteredTitle = _titleController.text;
    final todo = Todo.create(title: enteredTitle, category: _selectedCategory);
    widget.onAddTodo(todo);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + keyboardSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 74, 55, 128),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ), // Rounded corners
                  ),
                  label: Text('Item Name'),
                ),
              ),

              DropdownButton(
                value: _selectedCategory,
                items:
                    Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase()),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _submitTodoData,
                    child: const Text('Save Item'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
