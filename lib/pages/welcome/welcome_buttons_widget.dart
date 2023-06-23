import 'package:bikerace/pages/login/login_page.dart';
import 'package:bikerace/pages/signUp/signup_page.dart';
import 'package:flutter/material.dart';

Column WelcomeButtons(BuildContext context) {
  return Column(
    children: [
      SizedBox(
        width: double.maxFinite,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SignUp(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            backgroundColor: Colors.white,
            elevation: 0,
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 8,
            ),
          ),
          child: Text(
            "Sign Up",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.025,
              color: Colors.black,
            ),
          ),
        ),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.01,
      ),
      SizedBox(
        width: double.maxFinite,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.grey[500],
            shape: const StadiumBorder(),
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 8,
            ),
          ),
          child: Text(
            "Log In",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.025,
              color: Colors.black,
            ),
          ),
        ),
      ),
    ],
  );
}
