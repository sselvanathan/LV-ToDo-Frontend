import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Todo {
  int id;
  String name;

  Todo({required this.id, required this.name});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(id: json['id'], name: json['name']);
  }
}

class Todos extends StatefulWidget {
  const Todos({Key? key}) : super(key: key);

  @override
  TodosState createState() => TodosState();
}

class TodosState extends State<Todos> {
  late Future<List<Todo>> futureTodos;

  Future<List<Todo>> fetchTodos() async {
    http.Response response = await http
        .get(Uri.parse(dotenv.env['API_URL_GET_TODOS'] ?? 'API_URL not found'));

    List todos = jsonDecode(response.body);

    return todos.map((todo) => Todo.fromJson(todo)).toList();
  }

  @override
  void initState() {
    super.initState();
    futureTodos = fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ToDo'),
        ),
        body: FutureBuilder<List<Todo>>(
            future: futureTodos,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Todo todo = snapshot.data![index];
                      return ListTile(
                        title: Text(todo.name),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return const CircularProgressIndicator();
            }));
  }
}
