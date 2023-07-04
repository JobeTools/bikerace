import 'package:bikerace/pages/welcome/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

Row loginBack(BuildContext context) {
  return Row(
    children: [
      ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            PageTransition(
              type: PageTransitionType.fade, // Apply fade transition
              child: const WelcomePage(),
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
