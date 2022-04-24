import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lvTodo/models/current_user.dart';

class Api {
  final String? apiUrl = dotenv.env['API_URL'];

  postData(uri, json) async {
    String postUrl = apiUrl! + uri;

    http.Response response = await http.post(
      Uri.parse(postUrl),
      body: jsonEncode(json),
      headers: _setHeaders(),
    );

    return response;
  }

  deleteData(uri) async {
    String deleteUrl = apiUrl! + uri;

    return await http.delete(
        Uri.parse(deleteUrl),
      headers: _setHeaders(),
    );
  }

  updateData(uri, json) async {
    String putUrl = apiUrl! + uri;

    return await http.put(Uri.parse(putUrl),
        headers: _setHeaders(),
        body: jsonEncode(json));
  }

  getData(uri) async {
    String getUrl = apiUrl! + uri;
    var token = await CurrentUser().getToken();

    return await http.get(
        Uri.parse(getUrl),
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );
  }

  _setHeaders() {
    var token = CurrentUser().getToken();

    var headers =  {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    };

    return headers;
  }
}
