import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lvTodo/providers/AuthenticationProvider.dart';
import 'package:lvTodo/providers/TodoProvider.dart';
import 'package:lvTodo/screens/home.dart';
import 'package:lvTodo/screens/login.dart';
import 'package:lvTodo/screens/register.dart';
import 'package:lvTodo/screens/todos.dart';
import 'package:provider/provider.dart';

Future main() async {
  await dotenv.load();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AuthenticationProvider(),
        child: Consumer<AuthenticationProvider>(
            builder: (context, authenticationProvider, child) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider<TodoProvider>(
                    create: (context) => TodoProvider()),
                ChangeNotifierProvider<AuthenticationProvider>(
                    create: (context) => AuthenticationProvider()),
              ],
              child: MaterialApp(title: 'LV ToDo', routes: {
                '/': (context) {
                  final authenticationProvider = Provider.of<AuthenticationProvider>(context);
                  if (authenticationProvider.isAuthenticated) {
                    return const Home();
                  }
                  return const Login();
                },
                'login': (context) => const Login(),
                'register': (context) => const Register(),
                'home': (context) => const Home(),
                'todo/show/all': (context) => const Todos(),
              }));
        }));
  }
}
