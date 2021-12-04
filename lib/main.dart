import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:lvTodo/screens/login.dart';
import 'package:lvTodo/screens/register.dart';
import 'package:lvTodo/screens/todos.dart';

Future<void> main() async{
  await dotenv.load();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        title: 'LV ToDo',
        home: const Login(),
      routes: {
          '/login': (context) => const Login(),
          '/register': (context) => const Register(),

      }
    );
  }
}
