import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_to_do_list/const/colors.dart';
import 'package:flutter_to_do_list/data/auth_data.dart';
import 'package:flutter_to_do_list/screen/home.dart';

class LogIN_Screen extends StatefulWidget {
  final VoidCallback? show;
  LogIN_Screen(this.show, {super.key});

  @override
  State<LogIN_Screen> createState() => _LogIN_ScreenState();
}

class _LogIN_ScreenState extends State<LogIN_Screen> {
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  bool _isPasswordVisible = false;
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(() {
      setState(() {});
    });
    _focusNode2.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColors,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.h),
              image(),
              SizedBox(height: 50.h),
              textfield(email, _focusNode1, 'Email', Icons.email),
              SizedBox(height: 10.h),
              textfield(password, _focusNode2, 'Password', Icons.password,),
              SizedBox(height: 8.h),
              account(),
              SizedBox(height: 20.h),
              Login_bottom(),
            ],
          ),
        ),
      ),
    );
  }

  Widget account() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Don't have an account?",
            style: TextStyle(color: Colors.grey[700], fontSize: 13.sp),
          ),
          SizedBox(width: 5.w),
          GestureDetector(
            onTap: widget.show,
            child: Text(
              'Sign UP',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget Login_bottom() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: GestureDetector(
        onTap: () async {
          if (email.text.isEmpty || password.text.isEmpty) {
            _showError('Please fill in both fields.');
          } else if (!_isValidEmail(email.text)) {
            _showError('Please enter a valid email.');
          } else {
            try {
              await AuthenticationRemote().login(email.text, password.text);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home_Screen(),));
            } catch (error) {
              _showError('An error occurred: $error');
            }
          }
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 45.h,
          decoration: BoxDecoration(
            color: custom_green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'LogIn',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }


  Widget textfield(TextEditingController _controller, FocusNode _focusNode,
      String typeName, IconData iconss) {
    bool isPasswordField = typeName.toLowerCase() == "password";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          obscureText: isPasswordField && !_isPasswordVisible,
          style: TextStyle(fontSize: 18, color: Colors.black),
          decoration: InputDecoration(
            prefixIcon: Icon(
              iconss,
              color: _focusNode.hasFocus ? custom_green : Color(0xffc5c5c5),
            ),
            suffixIcon: isPasswordField
                ? IconButton(
              icon: Icon(
                _isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: _isPasswordVisible ? custom_green : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            )
                : null,
            contentPadding:
            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            hintText: typeName,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color(0xffc5c5c5),
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: custom_green,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget image() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          color: backgroundColors,
          image: DecorationImage(
            image: AssetImage('images/7.png'),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blue.shade400,
        duration: Duration(seconds: 3),
      ),
    );
  }
}
