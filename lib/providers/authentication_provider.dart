import 'package:flutter/foundation.dart';
import 'package:lvTodo/services/user_service.dart';

class AuthenticationProvider extends ChangeNotifier {
  bool isAuthenticated = false;
  UserService userService = UserService();

  AuthenticationProvider();

  Future<String> login(String email, String password, String deviceName) async {
      String token = await userService.login(email, password, deviceName);
      notifyListeners();
      isAuthenticated = true;

      return token;
  }

  Future<String> register(
      String name,
      String email,
      String password,
      String passwordConfirm,
      String deviceName
      ) async {
    String token = await userService.register(
        name,
        email,
        password,
        passwordConfirm,
        deviceName
    );
    notifyListeners();
    isAuthenticated = true;

    return token;
  }
}