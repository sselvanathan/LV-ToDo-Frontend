import 'package:flutter/foundation.dart';
import 'package:lvTodo/models/current_user.dart';
import 'package:lvTodo/services/user_service.dart';

class AuthenticationProvider extends ChangeNotifier {
  bool isAuthenticated = false;
  UserService userService = UserService();
  CurrentUser currentUser = CurrentUser();

  AuthenticationProvider(){
    init();
  }

  Future<void> init() async {
    var token = currentUser.getToken;
    if (token.toString().isEmpty) {
      isAuthenticated = true;
    }
  }

  Future<void> login(String email, String password) async {
    var deviceName = currentUser.getDeviceName();

    String userData = await userService.login(email, password, deviceName);
    currentUser.setToken(userData);
    notifyListeners();
    isAuthenticated = true;
  }

  Future<String> register(
    String name,
    String email,
    String password,
    String passwordConfirm,
  ) async {
    var deviceName = currentUser.getDeviceName();

    String token = await userService.register(
        name, email, password, passwordConfirm, deviceName);
    currentUser.setToken(token);
    notifyListeners();
    isAuthenticated = true;

    return token;
  }

  Future<void> logOut() async {
    currentUser.setToken('');
    isAuthenticated = false;
    notifyListeners();
  }
}
