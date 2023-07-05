import 'package:bikerace/pages/login/login_page.dart';
import 'package:bikerace/pages/signUp/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WelcomeButtons(context),
    );
  }
}

class WelcomeButtons extends StatelessWidget {
  const WelcomeButtons(this.context);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.maxFinite,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 200),
                  pageBuilder: (_, __, ___) => const SignUp(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var begin = const Offset(1.0, 0.0);
                    var end = Offset.zero;
                    var curve = Curves.easeOut;

                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));

                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
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
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 200),
                  pageBuilder: (_, __, ___) => const LoginPage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var begin = const Offset(1.0, 0.0);
                    var end = Offset.zero;
                    var curve = Curves.easeOut;

                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));

                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
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
}
