import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
                    const TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                    const TextField(
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(labelText: 'Password'),
                    ),
                    const TextField(
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(labelText: 'Confirm Password'),
                    ),
                    ElevatedButton(
                      onPressed: () => {
                      Navigator.pushNamed(context, 'todo/show/all')
                    },
                      child: const Text('Register'),
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 36)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text('<- Back to Login')),
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
