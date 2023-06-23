import 'dart:ui';
import 'package:bikerace/pages/signUp/signup_form_widget.dart';
import 'package:bikerace/pages/signUp/signup_header_widget.dart';
import 'package:bikerace/pages/signUp/signup_nav.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/welcome/welcome.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 16,
                  left: 16,
                  bottom: 32,
                  top: 16,
                ),
                child: Column(children: [
                  SignUpNav(context),
                  const Spacer(),
                  SignUpHeaderWidget(context),
                  const Spacer(),
                  SignUpForm(context),
                  const Spacer(),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
