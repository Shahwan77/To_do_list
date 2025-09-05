import 'package:flutter/material.dart';
import 'package:flutter_to_do_list/const/colors.dart';
import 'package:flutter_to_do_list/data/auth_data.dart';

class SignUp_Screen extends StatefulWidget {
  final VoidCallback? show;
  SignUp_Screen(this.show, {super.key});

  @override
  State<SignUp_Screen> createState() => _SignUp_ScreenState();
}

class _SignUp_ScreenState extends State<SignUp_Screen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode3 = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(() => setState(() {}));
    _focusNode2.addListener(() => setState(() {}));
    _focusNode3.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColors,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, // Add form key
            child: Column(
              children: [
                SizedBox(height: 20),
                image(),
                SizedBox(height: 50),
                textfield(
                  emailController,
                  _focusNode1,
                  'Email',
                  Icons.email,
                      (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email cannot be empty';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                textfield(
                  passwordController,
                  _focusNode2,
                  'Password',
                  Icons.password,
                      (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password cannot be empty';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                textfield(
                  passwordConfirmController,
                  _focusNode3,
                  'Confirm Password',
                  Icons.password,
                      (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirm Password cannot be empty';
                    }
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                account(),
                SizedBox(height: 20),
                SignUP_bottom(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget account() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Don’t you have an account?",
            style: TextStyle(color: Colors.grey[700], fontSize: 14),
          ),
          SizedBox(width: 5),
          GestureDetector(
            onTap: widget.show,
            child: Text(
              'Login',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget SignUP_bottom() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () {
          if (_formKey.currentState!.validate()) {
            AuthenticationRemote()
                .register(emailController.text, passwordController.text, passwordConfirmController.text);
          }
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: custom_green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget textfield(
      TextEditingController _controller,
      FocusNode _focusNode,
      String typeName,
      IconData iconss,
      String? Function(String?)? validator,
      ) {
    bool isPasswordField = typeName.toLowerCase() == "password";
    bool isConfirmPasswordField = typeName.toLowerCase() == "confirm password";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextFormField(
          controller: _controller,
          focusNode: _focusNode,
          validator: validator,
          style: const TextStyle(fontSize: 18, color: Colors.black),
          obscureText: (isPasswordField && !_isPasswordVisible) ||
              (isConfirmPasswordField && !_isConfirmPasswordVisible),
          decoration: InputDecoration(
            prefixIcon: Icon(
              iconss,
              color: _focusNode.hasFocus ? custom_green : const Color(0xffc5c5c5),
            ),
            // 👇 Show separate eye icons for Password & Confirm Password
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
                : isConfirmPasswordField
                ? IconButton(
              icon: Icon(
                _isConfirmPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: _isConfirmPasswordVisible
                    ? custom_green
                    : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _isConfirmPasswordVisible =
                  !_isConfirmPasswordVisible;
                });
              },
            )
                : null,
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            hintText: typeName,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
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
}
