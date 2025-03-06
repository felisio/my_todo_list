import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_todo_list/models/todo.dart';
import 'package:my_todo_list/models/category.dart';
import 'package:dropdown_search/dropdown_search.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({super.key, required this.onAddTodo});

  final Function(Todo) onAddTodo;

  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  final _titleController = TextEditingController();
  Category? _selectedCategory;
  final List<String> categories = Category.values.map((e) => e.name).toList();

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text('Invalid input'),
            content: Text('Please enter a valid title and select a category'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text('Okay'),
              ),
            ],
          ),
    );
  }

  void _submitTodoData() {
    final enteredTitle = _titleController.text;
    if (enteredTitle.isEmpty || _selectedCategory == null) {
      _showErrorDialog();
      return;
    }
    final todo = Todo.create(title: enteredTitle, category: _selectedCategory!);
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
              const SizedBox(height: 8),
              Center(
                child: Image.asset(
                  'assets/icons/trophy-16.png',
                  width: 50,
                  height: 50,
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Add a new item',
                  style: GoogleFonts.chewy(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 136, 113, 198),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 74, 55, 128),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(5.0), // Rounded corners
                  ),
                  label: Text('Item Name'),
                ),
              ),
              const SizedBox(height: 16),
              DropdownSearch<String>(
                items: (f, cs) => categories,
                popupProps: PopupProps.menu(
                  fit: FlexFit.loose,
                  showSelectedItems: true,
                ),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = Category.values.firstWhere(
                      (category) => category.name == value,
                    );
                  });
                },
                compareFn: (String item1, String item2) {
                  return item1 == item2;
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
