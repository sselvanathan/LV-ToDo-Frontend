import 'package:flutter/foundation.dart';
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

  Future createTodoModel(String todoName) async {
    try {
      TodoModel createdTodo = await todoService.createTodoModel(todoName);
      todoModels.add(createdTodo);

      notifyListeners();
    } on Exception {
      if (kDebugMode) {
        print(Exception);
      }
    }
  }

  Future updateTodoModel(TodoModel todoModel) async {
    try {
      TodoModel updatedTodo = await todoService.updateTodoModel(todoModel);
      int index = todoModels.indexOf(todoModel);
      todoModels[index] = updatedTodo;

      notifyListeners();
    } on Exception {
      if (kDebugMode) {
        print(Exception);
      }
    }
  }

  Future deleteTodoModel(TodoModel todoModel) async {
    try {
      await todoService.deleteTodoModel(todoModel.id);
      todoModels.remove(todoModel);
      notifyListeners();
    } on Exception {
      if (kDebugMode) {
        print(Exception);
      }
    }
  }
}
