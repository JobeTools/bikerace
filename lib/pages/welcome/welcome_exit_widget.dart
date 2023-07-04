import 'package:bikerace/pages/homePage/home_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

Row WelcomeExit(BuildContext context) {
  return Row(
    children: [
      ElevatedButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: HomePage(),
            ),
            (route) => false, // Remove all previous routes from the stack
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
          "assets/icons/cross.png",
          height: 18,
        ),
      ),
    ],
  );
}
