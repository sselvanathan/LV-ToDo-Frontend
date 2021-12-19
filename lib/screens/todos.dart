import 'package:flutter/material.dart';
import 'package:lvTodo/models/todo_model.dart';
import 'package:lvTodo/services/todo_service.dart';
import 'package:lvTodo/widgets/todo/todo_edit_widget.dart';

class Todos extends StatefulWidget {
  const Todos({Key? key}) : super(key: key);

  @override
  TodosState createState() => TodosState();
}

class TodosState extends State<Todos> {
  late Future<List<TodoModel>> futureTodos;
  late TodoModel selectedTodo;
  TodoService apiService = TodoService();

  @override
  void initState() {
    super.initState();
    futureTodos = apiService.fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ToDo'),
        ),
        body: FutureBuilder<List<TodoModel>>(
            future: futureTodos,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      TodoModel todoModel = snapshot.data![index];
                      return ListTile(
                        title: Text(todoModel.name),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return TodoEditWidget(todoModel);
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
