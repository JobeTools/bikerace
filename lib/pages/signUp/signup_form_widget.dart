import 'dart:async';
import 'package:bikerace/authentication/Auth.dart';
import 'package:bikerace/pages/homePage/home_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm(BuildContext context, {Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isEmailFieldFocused = false;
  bool _isUsernameFieldFocused = false;
  bool _isPasswordFieldFocused = false;
  bool _isFormSubmitted = false;
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void dispose() {
    _usernameController.dispose();
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
    _submitForm();
  }

  Future<void> _submitForm() async {
    setState(() {
      _isLoading = true;
    });
    // Simulate form submission
    bool isSuccessful = await _performFormSubmission();
    setState(() {
      _isLoading = false;
    });
    // Show success/error message and redirect after 1 second
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isSuccessful ? 'Sign up successful' : 'Sign up failed'),
        backgroundColor: isSuccessful ? Colors.green : Colors.red,
      ),
    );
    if (isSuccessful) {
      // If form submission is successful, update isAuthenticated to true
      Auth.isAuthenticated = true;
      // Redirect to the desired page after successful sign-up
      // Replace the placeholder code with the appropriate page
      Timer(
        Duration(seconds: 1),
        () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
      );
    }
  }

  Future<bool> _performFormSubmission() async {
    // TODO: Implement sign-up logic here
    // You can create a new user account and store the user's information
    // Return true if the sign-up is successful, false otherwise.
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    // Perform validation and sign-up logic based on your requirements
    // For example, you can check if the username or email already exists
    // or if the password meets the required criteria.
    // Replace this logic with your own sign-up logic

    if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      // Simulate a delay to show the loading indicator
      await Future.delayed(Duration(seconds: 2));
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
              _buildFormField(
                controller: _usernameController,
                labelText: 'Username',
                fieldColor:
                    _isUsernameFieldFocused ? Colors.white : Colors.black,
                isPasswordField: false,
                isEmailField: false,
                validator: validateUsername,
              ),
              SizedBox(height: fieldHeight),
              _buildFormField(
                controller: _emailController,
                labelText: 'Email',
                fieldColor: _isEmailFieldFocused ? Colors.white : Colors.black,
                isPasswordField: false,
                isEmailField: true,
                validator: validateEmail,
              ),
              SizedBox(height: fieldHeight),
              _buildFormField(
                controller: _passwordController,
                labelText: 'Password',
                fieldColor:
                    _isPasswordFieldFocused ? Colors.white : Colors.black,
                isPasswordField: true,
                isEmailField: false,
                validator: validatePassword,
              ),
              SizedBox(height: fieldHeight),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveForm,
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: buttonFontSize,
                            color: Colors.black, // Set text color to white
                          ),
                        ),
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    backgroundColor:
                        Colors.white, // Set button background color
                    elevation: 0,
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 8,
                    ),
                  ),
                ),
              ),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String labelText,
    required Color fieldColor,
    required bool isPasswordField,
    required bool isEmailField,
    required String? Function(String?) validator,
  }) {
    final UnderlineInputBorder focusedBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: fieldColor),
    );

    final UnderlineInputBorder enabledBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: fieldColor),
    );

    final String? errorText =
        _isFormSubmitted ? validator(controller.text) : null;

    return Semantics(
      label: labelText,
      child: TextFormField(
        controller: controller,
        obscureText: isPasswordField && !_isPasswordVisible,
        enableSuggestions: !isPasswordField,
        autocorrect: !isPasswordField,
        keyboardType:
            isEmailField ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: labelText,
          labelStyle: TextStyle(color: fieldColor),
          focusedBorder: focusedBorder,
          enabledBorder: enabledBorder,
          suffixIcon: isPasswordField
              ? IconButton(
                  onPressed: _togglePasswordVisibility,
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: fieldColor,
                  ),
                )
              : null,
          errorText: errorText,
          errorStyle: TextStyle(color: Colors.red),
        ),
        style: TextStyle(color: Colors.white), // Set text color to white
        onChanged: (_) {
          setState(() {
            _isUsernameFieldFocused = false;
            _isEmailFieldFocused = false;
            _isPasswordFieldFocused = false;
          });
        },
        onTap: () {
          setState(() {
            _isUsernameFieldFocused = false;
            _isEmailFieldFocused = false;
            _isPasswordFieldFocused = false;
          });
        },
        validator: validator,
      ),
    );
  }

  String? validateUsername(String? value) {
    if (value!.isEmpty) {
      return "Please enter your username";
    }
    if (value.length > 15) {
      return "Username must be 15 characters or less";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "Please enter your email";
    }
    if (!EmailValidator.validate(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Please enter your password";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    if (value.length > 20) {
      return "Password must be 20 characters or less";
    }
    return null;
  }
}
