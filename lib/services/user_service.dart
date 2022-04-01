import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:lvTodo/networking/api.dart';

class UserService{
  UserService();

  Future<String> login(String email, String password, String deviceName) async {
    var loginUri = 'auth/login/';
    var json = {
      'email': email,
      'password': password,
      'device_name': deviceName
    };

    http.Response response = await Api().postData(loginUri, json);

    if (kDebugMode) {
      print(response.statusCode);
    }

    if (response.statusCode == HttpStatus.unprocessableEntity) {
      Map<String, dynamic> body = jsonDecode(response.body);
      Map<String, dynamic> errors = body['errors'];
      String errorMessage = '';
      errors.forEach((key, value) {
        value.forEach((element) {
          errorMessage += element + '\n';
        });
      });
      throw Exception(errorMessage);
    }

    return response.body;
  }

  Future<String> register(String name, String email, String password,
      String passwordConfirm, String deviceName) async {
    var registerUri = 'auth/login/';

    var json = {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirm,
      'device_name': deviceName
    };

    http.Response response = await Api().postData(registerUri, json);

    if (kDebugMode) {
      print(response.statusCode);
    }

    if (response.statusCode == HttpStatus.unprocessableEntity) {
      Map<String, dynamic> body = jsonDecode(response.body);
      Map<String, dynamic> errors = body['errors'];
      String errorMessage = '';
      errors.forEach((key, value) {
        value.forEach((element) {
          errorMessage += element + '\n';
        });
      });
      throw Exception(errorMessage);
    }

    return response.body;
  }
}
