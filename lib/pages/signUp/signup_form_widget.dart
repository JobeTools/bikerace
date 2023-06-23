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

    // TODO: Perform form submission logic
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
              _buildUsernameField(),
              SizedBox(height: fieldHeight),
              _buildEmailField(),
              SizedBox(height: fieldHeight),
              _buildPasswordField(),
              SizedBox(height: fieldHeight),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveForm,
                  child: Text(
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUsernameField() {
    final Color fieldColor =
        _isUsernameFieldFocused ? Colors.white : Colors.black;
    final UnderlineInputBorder focusedBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: fieldColor),
    );
    final UnderlineInputBorder enabledBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: fieldColor),
    );
    final String? errorText =
        _isFormSubmitted && _usernameController.text.isEmpty
            ? "Please enter your username"
            : _isFormSubmitted && _usernameController.text.length > 15
                ? "Username must be 15 characters or less"
                : null;

    return TextFormField(
      controller: _usernameController,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Username',
        labelStyle: TextStyle(color: fieldColor),
        focusedBorder: focusedBorder,
        enabledBorder: enabledBorder,
        errorText: errorText,
        errorStyle: TextStyle(color: Colors.red),
      ),
      style: TextStyle(color: Colors.white), // Set text color to white
      onChanged: (_) {
        setState(() {
          _isUsernameFieldFocused = true;
          _isEmailFieldFocused = false;
          _isPasswordFieldFocused = false;
        });
      },
      onTap: () {
        setState(() {
          _isUsernameFieldFocused = true;
          _isEmailFieldFocused = false;
          _isPasswordFieldFocused = false;
        });
      },
      validator: (_) {
        if (_usernameController.text.isEmpty) {
          return "Please enter your username";
        }
        if (_usernameController.text.length > 15) {
          return "Username must be 15 characters or less";
        }
        return null;
      },
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
          _isUsernameFieldFocused = false;
          _isPasswordFieldFocused = false;
        });
      },
      onTap: () {
        setState(() {
          _isEmailFieldFocused = true;
          _isUsernameFieldFocused = false;
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
            : _isFormSubmitted && _passwordController.text.length < 6
                ? "Password must be at least 6 characters"
                : _isFormSubmitted && _passwordController.text.length > 20
                    ? "Password must be 20 characters or less"
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
          _isUsernameFieldFocused = false;
          _isEmailFieldFocused = false;
        });
      },
      onTap: () {
        setState(() {
          _isPasswordFieldFocused = true;
          _isUsernameFieldFocused = false;
          _isEmailFieldFocused = false;
        });
      },
      validator: (_) {
        if (_passwordController.text.isEmpty) {
          return "Please enter your password";
        }
        if (_passwordController.text.length < 6) {
          return "Password must be at least 6 characters";
        }
        if (_passwordController.text.length > 20) {
          return "Password must be 20 characters or less";
        }
        return null;
      },
    );
  }
}
