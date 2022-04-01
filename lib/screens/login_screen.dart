import 'package:flutter/material.dart';
import 'package:lvTodo/providers/authentication_provider.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login();

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String errorMessage = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        color: Theme.of(context).primaryColorDark,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                elevation: 8,
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter email';
                            }
                            return null;
                          },
                          onChanged: (text) =>
                              setState(() => errorMessage = ''),
                          decoration: const InputDecoration(labelText: 'Email'),
                        ),
                        TextFormField(
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          controller: passwordController,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter password';
                            }

                            return null;
                          },
                          onChanged: (text) =>
                              setState(() => errorMessage = ''),
                          decoration:
                              const InputDecoration(labelText: 'Password'),
                        ),
                        ElevatedButton(
                          onPressed: () => submit(),
                          child: const Text('Login'),
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 36)),
                        ),
                        Text(errorMessage,
                            style: const TextStyle(color: Colors.red)),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, 'register');
                            },
                            child: const Text('Register new User'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> submit() async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }

    final AuthenticationProvider provider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    try {
      await provider.login( emailController.text, passwordController.text);
    } catch (Exception) {
      setState(() {
        errorMessage = Exception.toString().replaceAll('Exception: ', '');
      });
    }
  }
}
