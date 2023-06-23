import 'package:bikerace/pages/welcome/welcome_buttons_widget.dart';
import 'package:bikerace/pages/welcome/welcome_exit_widget.dart';
import 'package:bikerace/pages/welcome/welcome_header_widget.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/welcome/welcome.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              right: 16,
              left: 16,
              bottom: 32,
              top: 16,
            ),
            child: Column(children: [
              WelcomeExit(context),
              const Spacer(),
              WelcomeHeader(context),
              const Spacer(),
              WelcomeButtons(context),
              const Spacer(),
            ]),
          ),
        ),
      ),
    );
  }
}
