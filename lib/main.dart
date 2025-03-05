import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:my_todo_list/todo_screen.dart';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:my_todo_list/models/todo.dart';
import 'package:my_todo_list/models/category.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 74, 55, 128),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(TodoAdapter());
  Hive.registerAdapter(CategoryAdapter());
  await Hive.openBox<Todo>('todoListBox');
  await dotenv.load(fileName: ".env");

  bool kReleaseMode = true;

  runApp(DevicePreview(enabled: !kReleaseMode, builder: (context) => MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        colorScheme: kColorScheme,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 206, 198, 230),
          ),
        ),
      ),
      home: TodoScreen(),
    );
  }
}
