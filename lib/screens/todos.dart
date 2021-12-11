import 'dart:convert';
import 'dart:io';
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
  late Todo selectedTodo;
  final _formKey = GlobalKey<FormState>();
  final todoNameController = TextEditingController();

  Future<List<Todo>> fetchTodos() async {
    String uri = dotenv.env['API_URL_CRUD_TODOS'] ?? 'API_URL not found';
    http.Response response = await http.get(Uri.parse(uri));

    List todos = jsonDecode(response.body);

    return todos.map((todo) => Todo.fromJson(todo)).toList();
  }

  Future saveTodo() async {
    final form = _formKey.currentState;

    if(!form!.validate()){
      return;
    }

    String? todo = dotenv.env['API_URL_CRUD_TODOS'];
    String? todoId = selectedTodo.id.toString();
    String uri = todo! + todoId;

    await http.put(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({
          'name': todoNameController.text
        })
    );

    Navigator.pop(context);
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
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            selectedTodo = todo;
                            todoNameController.text = todo.name;
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                          children: <Widget>[
                                            TextFormField(
                                                controller: todoNameController,
                                                validator: (String? value){
                                                  if (value!.isEmpty){
                                                    return 'Enter category name';
                                                  }
                                                  return null;
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Todo name',
                                                )),
                                            ElevatedButton(
                                                onPressed: () => saveTodo(),
                                                child: const Text('Save'))
                                          ],
                                        ),
                                      ));
                                });
                          },
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return const CircularProgressIndicator();
            }));
  }
}
