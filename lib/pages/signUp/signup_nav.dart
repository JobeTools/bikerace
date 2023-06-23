import 'package:bikerace/pages/welcome/welcome_page.dart';
import 'package:flutter/material.dart';

Row SignUpNav(BuildContext context) {
  const double arrowImageHeight = 18.0;
  final double fontSize = MediaQuery.of(context).size.height * 0.035;

  return Row(
    children: [
      ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const WelcomePage(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.white70,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(8),
        ),
        child: Image.asset(
          "assets/icons/arrow.png",
          height: arrowImageHeight,
        ),
      ),
      const SizedBox(width: 8),
      Text(
        "Create an Account",
        style: TextStyle(
          fontSize: fontSize,
          color: const Color.fromARGB(255, 49, 49, 49),
          fontWeight: FontWeight.w600,
          letterSpacing: 2,
        ),
      ),
    ],
  );
}
