import 'package:bikerace/pages/homePage/home_page.dart';
import 'package:flutter/material.dart';

Row WelcomeExit(BuildContext context) {
  return Row(
    children: [
      ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
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
          "assets/icons/cross.png",
          height: 18,
        ),
      ),
    ],
  );
}
