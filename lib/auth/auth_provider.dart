import 'package:flutter/material.dart';
import '../data/auth_data.dart';
import '../screen/login.dart';

class AuthProvider with ChangeNotifier {
  final AuthenticationRemote _authRemote = AuthenticationRemote();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> login(String email, String password) async {
    _setLoading(true);
    try {
      await _authRemote.login(email, password);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }
    _setLoading(false);
  }

  Future<void> register(
      String email, String password, String confirmPassword) async {
    _setLoading(true);
    try {
      await _authRemote.register(email, password, confirmPassword);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }
    _setLoading(false);
  }

  Future<void> logout(BuildContext context) async {
    await _authRemote.logout();
    notifyListeners();

    // Navigate to Login Screen after logout
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LogIN_Screen(null)), // ⬅ Your login screen
          (route) => false, // Remove all previous routes
    );
  }


  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
