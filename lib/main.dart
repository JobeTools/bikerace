// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'dart:async';
import "package:audioplayers/audioplayers.dart";
import 'package:flutter/material.dart';
import 'DistanceCalculation.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Race',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Testing'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {
  String Countdown = "";
  @override
  void initState() {
    super.initState();
  }

  StartP() {
    Timer(Duration(seconds: 1), () {
      final player = AudioPlayer();
      player.play(AssetSource('Cntdn.mp3'));
      setState(() {
        Countdown = "3";
      });
      Timer(Duration(seconds: 1), () {
        setState(() {
          Countdown = "2";
        });
        Timer(Duration(seconds: 1), () {
          setState(() {
            Countdown = "1";
            Timer(Duration(seconds: 1), () {
              setState(() {
                Countdown = "GO!";
                player.stop();
                determinePosition();
                TimeTaken();

              });
            });
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Text(Countdown, style: TextStyle(fontSize: 70)),
              ElevatedButton(
                child: Text('Start Race'),
                onPressed: () {
                  StartP();
                },
              ),
            ])));
  }
}
