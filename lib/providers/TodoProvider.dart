import 'package:flutter/material.dart';
import 'package:lvTodo/models/todo_model.dart';
import 'package:lvTodo/services/todo_service.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoModel> todoModels = [];
  late TodoService todoService;

  TodoProvider() {
    todoService = TodoService();
    init();
  }

  Future init() async {
    todoModels = await todoService.fetchTodos();
    notifyListeners();
  }

  Future updateTodoModel(TodoModel todoModel) async{
    try {
      TodoModel updatedTodo = await todoService.updateTodoModel(todoModel);
      int index  = todoModels.indexOf(todoModel);
      todoModels[index] = updatedTodo;

      notifyListeners();
    } catch(Exception){
      print(Exception);
    }
  }
}