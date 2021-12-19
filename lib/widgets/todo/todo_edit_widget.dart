import 'package:flutter/material.dart';
import 'package:lvTodo/models/todo_model.dart';
import 'package:lvTodo/services/todo_service.dart';

class TodoEditWidget extends StatefulWidget {
  final TodoModel todoModel;

  const TodoEditWidget(this.todoModel, {Key? key}) : super(key: key);

  @override
  _TodoEditState createState() => _TodoEditState();
}

class _TodoEditState extends State<TodoEditWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final todoNameController = TextEditingController();
  TodoService apiService = TodoService();
  String errorMessage = '';

  @override
  void initState() {
    todoNameController.text = widget.todoModel.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                  onChanged: (text) => setState(() => errorMessage = ''),
                  controller: todoNameController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter todo name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Todo name',
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () => saveTodo(), child: const Text('Save')),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel')),
                ],
              ),
              Text(errorMessage, style: const TextStyle(color: Colors.red))
            ],
          ),
        ));
  }

  Future saveTodo() async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }

    apiService.updateTodo(widget.todoModel.id, todoNameController.text)
    .then((TodoModel todoModel) => Navigator.pop(context))
    .catchError((exception){
      setState(() {
        errorMessage = exception.toString();
      });
    });
  }
}
