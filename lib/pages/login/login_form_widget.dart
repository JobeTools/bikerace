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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _saveForm() {
    setState(() {
      _isFormSubmitted = true;
    });

    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    // Simulate form submission
    bool isSuccessful = _performFormSubmission();

    // Show success/error message and redirect after 1 second
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:
          Text(isSuccessful ? 'Successful' : 'Password or email is incorrect'),
      backgroundColor: isSuccessful ? Colors.green : Colors.red,
    ));

    Timer(Duration(seconds: 1), () {
      if (isSuccessful) {
        // If form submission is successful, update isAuthenticated to true
        Auth.isAuthenticated = true;

        // Redirect to the home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    });
  }

  bool _performFormSubmission() {
    // TODO: Implement form submission logic here
    // You can check the entered email and password,
    // interact with APIs or databases, etc.
    // Return true if the submission is successful, false otherwise.

    String email = _emailController.text;
    String password = _passwordController.text;

    // Perform validation logic based on your requirements
    // For example, you can compare the entered email and password
    // with a pre-defined email and password combination.

    // Replace this logic with your own validation
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
    // TODO: Implement the logic for the "Forgot Password?" button
    //show forgot password page.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Forgot Password'),
          content: Text('Please contact support for password recovery.'),
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
                  onPressed: _saveForm,
                  child: Text(
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
      style: TextStyle(color: Colors.white), // Set text color to white
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
      validator: (_) {
        if (_emailController.text.isEmpty) {
          return "Please enter your email";
        }
        if (!EmailValidator.validate(_emailController.text)) {
          return "Please enter a valid email";
        }
        return null;
      },
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
      style: TextStyle(color: Colors.white), // Set text color to white
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
      validator: (_) {
        if (_passwordController.text.isEmpty) {
          return "Please enter your password";
        }
        return null;
      },
    );
  }
}
