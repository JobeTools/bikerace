import 'package:bikerace/calculations/AI.dart';
import 'package:bikerace/calculations/DistanceCalculation.dart';
import 'package:bikerace/pages/welcome/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.grey,
              ),
              onPressed: () {
                // Perform function on press
              },
            ),
          ),
          const Spacer(),
          Container(
            height: MediaQuery.of(context).size.height - 215,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: LatLng(10, 10), zoom: 10)),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {
                // Start button pressed
                determinePosition();
                BasicRacingComputer();
              },
              child: Text(
                'Start',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                elevation: 0,
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 8,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 1), // vertical shadow
                ),
              ],
            ),
            child: Container(
              height: 60,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.accessibility_new),
                    onPressed: () {
                      // Navigate to "Race" page
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.play_circle_filled),
                    onPressed: () {
                      // Navigate to "Start" page
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.group),
                    onPressed: () {
                      // Navigate to "Community" page
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.explore),
                    onPressed: () {
                      // Navigate to "Explore" page
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.person),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WelcomePage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
