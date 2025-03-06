import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_todo_list/models/todo.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_todo_list/models/category.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NewTodoAssistant extends StatefulWidget {
  const NewTodoAssistant({super.key, required this.onAddTodo});

  final Function(List<Todo>) onAddTodo;

  @override
  State<NewTodoAssistant> createState() => _NewTodoAssistantState();
}

class _NewTodoAssistantState extends State<NewTodoAssistant> {
  final String apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';
  final String apiUrl = 'https://api.openai.com/v1/chat/completions';

  final _assistantController = TextEditingController();
  bool _isLoading = false;

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Error'),
            content: const Text(
              'An error occurred while generating the todo list.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'),
              ),
            ],
          ),
    );
  }

  Todo _parseTodoList(String item) {
    final itemSplited = item.split(':');
    final categoryString =
        itemSplited[0].replaceAll('-', '').trim().toLowerCase();

    final category = Category.values.firstWhere(
      (category) => category.name == categoryString,
    );

    return Todo.create(title: itemSplited[1].trim(), category: category);
  }

  Future<void> _generateTodoList() async {
    final assistantText =
        'Generate a to-do list based on the following description: ${_assistantController.text}. Return the list in bullet points with a maximum of 10 items. For each item, also specify the category it belongs to: ${CategoryAdapter().categoryNames}. return the list following the format: - category: item';
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'user', 'content': assistantText},
          ],
          'max_tokens': 150,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final todoList = responseBody['choices'][0]['message']['content'];

        final List<String> lines = todoList.split('\n');

        final List<Todo> todoItems =
            lines
                .where((line) => line.trim().isNotEmpty)
                .map((item) => _parseTodoList(item))
                .toList();

        widget.onAddTodo(todoItems);
        Navigator.pop(context);
      } else {
        _showErrorDialog();
      }
    } catch (error) {
      _showErrorDialog();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _submitAssistantText() {
    final assistantText = _assistantController.text;
    if (assistantText.isEmpty) {
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: const Text('Invalid description'),
              content: const Text('Please enter a valid description.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text('Okay'),
                ),
              ],
            ),
      );
    } else {
      _generateTodoList();
    }
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
            children: [
              const SizedBox(height: 8),
              Center(
                child: Image.asset(
                  'assets/icons/bot-16.png',
                  width: 50,
                  height: 50,
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Add your magic todo list',
                  style: GoogleFonts.chewy(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 136, 113, 198),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _assistantController,
                maxLines: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ), // Rounded corners
                  ),
                  hintText:
                      'Describe your goal and let the AI create your tasks!',
                  label: Text('Assistant'),
                ),
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
                  ElevatedButton.icon(
                    onPressed: _submitAssistantText,
                    icon:
                        _isLoading
                            ? const Icon(Icons.hourglass_bottom)
                            : const Icon(Icons.auto_fix_high),
                    label:
                        _isLoading
                            ? const Text('Generating...')
                            : const Text('Generate'),
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
