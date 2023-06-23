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
              _buildEmailField(),
              SizedBox(height: fieldHeight),
              _buildPasswordField(),
              SizedBox(height: fieldHeight),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {},
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
