import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to LV ToDo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Logged In!'),
        ),
        body: const Center(
          child: Text(
            'Welcome',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
