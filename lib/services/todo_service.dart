import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:lvTodo/models/todo_model.dart';
import 'package:lvTodo/networking/api.dart';

class TodoService {
  TodoService();

  final String? crudTodosUri = 'todos/';

  Future<List<TodoModel>> fetchTodos() async {
    http.Response response = await Api().getData(crudTodosUri);

    List todos = jsonDecode(response.body)['data'];

    return todos.map((todo) => TodoModel.fromJson(todo)).toList();
  }

  Future<TodoModel> createTodoModel(String todoName) async {
    var json = {'name': todoName};
    http.Response response = await Api().postData(crudTodosUri, json);

    if (response.statusCode != HttpStatus.created) {
      throw Exception('Error happened on Create');
    }

    return TodoModel.fromJson(jsonDecode(response.body)['data']);
  }

  Future<TodoModel> updateTodoModel(TodoModel todoModel) async {
    String todoModelId = todoModel.id.toString();
    String uri = crudTodosUri! + todoModelId;
    var json = {
    'id': todoModelId,
    'name': todoModel.name,
    };
    http.Response response = await Api().updateData(uri, json);

    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Error happened on Update');
    }

    return TodoModel.fromJson(jsonDecode(response.body)['data']);
  }

  Future<void> deleteTodoModel(todoModelId) async {
    String uri = crudTodosUri! + todoModelId.toString();

    http.Response response = await Api().deleteData(uri);

    if (response.statusCode != HttpStatus.noContent) {
      throw Exception('Error happened on Delete');
    }
  }
}
