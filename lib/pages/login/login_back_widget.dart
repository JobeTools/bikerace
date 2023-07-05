import 'package:bikerace/pages/welcome/welcome_page.dart';
import 'package:flutter/material.dart';

Row loginBack(BuildContext context) {
  return Row(
    children: [
      ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 200),
              pageBuilder: (_, __, ___) => const WelcomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                var begin = const Offset(-1.0, 0.0); // Slide from left to right
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
          backgroundColor: Colors.white70,
          shape: const CircleBorder(),
          padding: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 8,
          ),
        ),
        child: Image.asset(
          "assets/icons/arrow.png",
          height: 18,
        ),
      ),
    ],
  );
}
