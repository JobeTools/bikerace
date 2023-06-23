import 'package:flutter/material.dart';

Column LoginHeaderWidget(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image.asset(
        "assets/icons/logo.png",
        height: 100,
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        "Welcome Back! \n Log in and start racing",
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.height * 0.035,
          color: Color.fromARGB(255, 49, 49, 49),
          fontWeight: FontWeight.w600,
          letterSpacing: 2,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}
