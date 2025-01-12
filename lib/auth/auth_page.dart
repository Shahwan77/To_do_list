import 'package:flutter/material.dart';
import 'package:flutter_to_do_list/screen/SingUP.dart';
import 'package:flutter_to_do_list/screen/login.dart';

class Auth_Page extends StatefulWidget {
  const Auth_Page({super.key});

  @override
  State<Auth_Page> createState() => _Auth_PageState();
}

class _Auth_PageState extends State<Auth_Page> {
  bool _isLogin = true;

  // Toggle between login and signup screen
  void _toggleAuthScreen() {
    setState(() {
      _isLogin = !_isLogin; // Toggle between true and false
    });
  }

  @override
  Widget build(BuildContext context) {
    // Depending on the value of _isLogin, display the appropriate screen
    return Scaffold(
      body: _isLogin ? LogIN_Screen(_toggleAuthScreen) : SignUp_Screen(_toggleAuthScreen),
    );
  }
}
