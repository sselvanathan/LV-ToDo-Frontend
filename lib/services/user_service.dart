import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UserService {
  UserService();

  final String? registerUrl = dotenv.env['API_URL_REGISTER'];

  Future<String> register(
      String name,
      String email,
      String password,
      String passwordConfirm,
      String deviceName
      ) async {
    String uri = registerUrl!;

    http.Response response = await http.post(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode(
            {
              'name': name,
              'email': email,
              'password': password,
              'password_confirmation': passwordConfirm,
              'device_name': deviceName
            }));
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