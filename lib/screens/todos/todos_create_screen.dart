import 'package:flutter/material.dart';

class TodoCreate extends StatelessWidget {
  const TodoCreate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a new Todo'),
      ),
      body: Container(
        color: Theme.of(context).primaryColorDark,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              elevation: 8,
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    const TextField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(labelText: 'Name'),
                    ),
                    TextField(
                      readOnly: true,
                      onTap: () async {
                        final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            initialDate: DateTime.now(),
                            lastDate: DateTime(2022));
                        if (date != null) {
                          print(date);
                        }
                      },
                    ),
                    ElevatedButton(
                      onPressed: () => {
                        Navigator.pushNamed(context, 'todo/show/all')
                      },
                      child: const Text('Create Todo'),
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 36)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Back to ToDo List')),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
