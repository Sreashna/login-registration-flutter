import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  String? _registeredEmail;
  String? _registeredPassword;

  Future<bool> register(
      String name, String email, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    _registeredEmail = email;
    _registeredPassword = password;

    isLoading = false;
    notifyListeners();
    return true;
  }
  Future<bool> login(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    if (email == _registeredEmail &&
        password == _registeredPassword) {
      isLoading = false;
      notifyListeners();
      return true;
    } else {
      errorMessage = "Invalid email or password";
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
