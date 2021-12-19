import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:lvTodo/models/todo_model.dart';

class TodoService {
  TodoService();

  final String? crudTodosUrl = dotenv.env['API_URL_CRUD_TODOS'];

  Future<List<TodoModel>> fetchTodos() async {
    http.Response response = await http.get(Uri.parse(crudTodosUrl!));

    List todos = jsonDecode(response.body);

    return todos.map((todo) => TodoModel.fromJson(todo)).toList();
  }

  Future<TodoModel> updateTodo(id, name) async {
    String uri = crudTodosUrl! + id.toString();

    http.Response response = await http.put(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({'name': name}));

    if (response.statusCode != 200) {
      throw Exception('Error happened on Update');
    }

    return TodoModel.fromJson(jsonDecode(response.body));
  }
}
