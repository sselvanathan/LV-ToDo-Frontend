import 'package:flutter/material.dart';
import 'package:lvTodo/screens/login.dart';
import 'package:lvTodo/screens/register.dart';
import 'package:lvTodo/screens/todos.dart';

void main() => runApp(const MyApp());

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
