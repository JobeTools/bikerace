import 'package:bikerace/state_management/store.dart';
import 'package:flutter/material.dart';
import 'package:bikerace/pages/welcome/welcome_page.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Bike App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme),
        ),
        home: const WelcomePage(),
      ),
    );
  }
}
