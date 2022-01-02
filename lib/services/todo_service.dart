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

  Future<TodoModel> createTodoModel(String todoName) async {
    String uri = crudTodosUrl!;

    http.Response response = await http.post(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({'name': todoName}));

    if (response.statusCode != HttpStatus.created) {
      throw Exception('Error happened on Create');
    }

    return TodoModel.fromJson(jsonDecode(response.body));
  }

  Future<TodoModel> updateTodoModel(TodoModel todoModel) async {
    String uri = crudTodosUrl! + todoModel.id.toString();

    http.Response response = await http.put(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({'name': todoModel.name}));

    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Error happened on Update');
    }

    return TodoModel.fromJson(jsonDecode(response.body));
  }

  Future<void> deleteTodoModel(todoModelId) async {
    String uri = crudTodosUrl! + todoModelId.toString();

    http.Response response = await http.delete(Uri.parse(uri),
    );

    if (response.statusCode != HttpStatus.noContent) {
      throw Exception('Error happened on Delete');
    }
  }
}
