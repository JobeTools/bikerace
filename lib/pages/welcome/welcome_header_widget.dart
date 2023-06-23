import 'package:flutter/material.dart';

Column WelcomeHeader(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        "assets/icons/logo.png",
        height: 100,
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.01,
      ),
      Stack(
        children: [
          Text(
            'Race. \n Ride. \n Triumph!',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.06,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 2.5
                ..color = Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "Race. \n Ride. \n Triumph!",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.06,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ],
  );
}
