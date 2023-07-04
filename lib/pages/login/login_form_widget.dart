import 'dart:async';
import 'package:bikerace/authentication/Auth.dart';
import 'package:bikerace/pages/homePage/home_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm(BuildContext context, {Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isEmailFieldFocused = false;
  bool _isPasswordFieldFocused = false;
  bool _isFormSubmitted = false;
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _saveForm() async {
    setState(() {
      _isFormSubmitted = true;
      _errorMessage = '';
    });

    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    bool isSuccessful = await _performFormSubmission();

    setState(() {
      _isLoading = false;
    });

    if (isSuccessful) {
      Auth.isAuthenticated = true;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      setState(() {
        _errorMessage = 'Email or password is incorrect';
      });
    }
  }

  Future<bool> _performFormSubmission() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Simulate asynchronous form submission
    await Future.delayed(Duration(seconds: 2));

    // Implement actual form submission logic here, such as validating against a database or API
    // Replace the following logic with your own validation and authentication implementation

    // Simulate authentication
    if (email == 'example@gmail.com' && password == 'password') {
      return true;
    } else {
      return false;
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _handleForgotPassword() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Forgot Password'),
          content: Text('An email has been sent to the account holder'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double fieldHeight = height * 0.01;
    final double buttonFontSize = height * 0.025;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: _isFormSubmitted
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildEmailField(),
              SizedBox(height: fieldHeight),
              _buildPasswordField(),
              SizedBox(height: fieldHeight),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: _handleForgotPassword,
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Color.fromARGB(188, 71, 165, 241),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveForm,
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : Text(
                          "Log In",
                          style: TextStyle(
                            fontSize: buttonFontSize,
                            color: Colors.black,
                          ),
                        ),
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    backgroundColor: Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 8,
                    ),
                  ),
                ),
              ),
              if (_errorMessage.isNotEmpty) SizedBox(height: fieldHeight),
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    final Color fieldColor = _isEmailFieldFocused ? Colors.white : Colors.black;
    final UnderlineInputBorder focusedBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: fieldColor),
    );
    final UnderlineInputBorder enabledBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: fieldColor),
    );
    final String? errorText = _isFormSubmitted &&
            _emailController.text.isNotEmpty &&
            !EmailValidator.validate(_emailController.text)
        ? "Please enter a valid email"
        : null;

    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Email',
        labelStyle: TextStyle(color: fieldColor),
        focusedBorder: focusedBorder,
        enabledBorder: enabledBorder,
        errorText: errorText,
        errorStyle: TextStyle(color: Colors.red),
      ),
      style: TextStyle(color: Colors.white),
      onChanged: (_) {
        setState(() {
          _isEmailFieldFocused = true;
        });
      },
      onTap: () {
        setState(() {
          _isEmailFieldFocused = true;
          _isPasswordFieldFocused = false;
        });
      },
      validator: (_) => FormValidator.validateEmail(_emailController.text),
    );
  }

  Widget _buildPasswordField() {
    final Color fieldColor =
        _isPasswordFieldFocused ? Colors.white : Colors.black;
    final UnderlineInputBorder focusedBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: fieldColor),
    );
    final UnderlineInputBorder enabledBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: fieldColor),
    );
    final String? errorText =
        _isFormSubmitted && _passwordController.text.isEmpty
            ? "Please enter your password"
            : null;

    return TextFormField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Password',
        labelStyle: TextStyle(color: fieldColor),
        focusedBorder: focusedBorder,
        enabledBorder: enabledBorder,
        suffixIcon: IconButton(
          onPressed: _togglePasswordVisibility,
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: fieldColor,
          ),
        ),
        errorText: errorText,
        errorStyle: TextStyle(color: Colors.red),
      ),
      style: TextStyle(color: Colors.white),
      onChanged: (_) {
        setState(() {
          _isPasswordFieldFocused = true;
        });
      },
      onTap: () {
        setState(() {
          _isEmailFieldFocused = false;
          _isPasswordFieldFocused = true;
        });
      },
      validator: (_) =>
          FormValidator.validatePassword(_passwordController.text),
    );
  }
}

class FormValidator {
  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return "Please enter your email";
    }
    if (!EmailValidator.validate(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return "Please enter your password";
    }
    return null;
  }
}
