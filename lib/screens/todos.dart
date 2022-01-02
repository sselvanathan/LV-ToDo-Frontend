import 'package:flutter/material.dart';
import 'package:lvTodo/models/todo_model.dart';
import 'package:lvTodo/providers/TodoProvider.dart';
import 'package:lvTodo/widgets/todo/todo_create_widget.dart';
import 'package:lvTodo/widgets/todo/todo_edit_widget.dart';
import 'package:provider/provider.dart';

class Todos extends StatefulWidget {
  const Todos({Key? key}) : super(key: key);

  @override
  TodosState createState() => TodosState();
}

class TodosState extends State<Todos> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    List<TodoModel> todos = provider.todoModels;

    return Scaffold(
        appBar: AppBar(
          title: const Text('ToDo'),
        ),
        body: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              TodoModel todoModel = todos[index];
              return ListTile(
                  title: Text(todoModel.name),
                  trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return TodoEditWidget(todoModel,
                                  provider.updateTodoModel);
                            });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => showDialog(
                          context: context,
                          builder: (context) {
                            return  AlertDialog(
                              title: const Text('Confirmation'),
                              content: const Text('Are you sure you want to delete this Todo?'),
                              actions: [
                                TextButton(
                                    onPressed: () => deleteTodoModel(provider.deleteTodoModel, todoModel),
                                    child: const Text('Confirm')
                                ),
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel')
                                ),
                              ],
                            );
                          }
                      ),
                    ),
                  ]
                  ));
            }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return TodoCreateWidget(provider.createTodoModel);
              });
        },
          child: const Icon(Icons.add),
      ),
    );
  }

  Future deleteTodoModel(Function callback, TodoModel todoModel) async{
    await callback(todoModel);
    Navigator.pop(context);
  }
}
