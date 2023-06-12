// ignore_for_file: file_names, non_constant_identifier_names, prefer_const_declarations,

import 'dart:async';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'AI.dart';

List<Position> Location = [];
List<double> SpeedA = [];
List<double> AltitudeA = [];
String long = "", lat = "", distance = "", speedR = "";
determinePosition() async {
  Position previousPosition;
  double FinalDistance = 0;
  double altimeter = 0; //bruh its legit used

  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.best,
    distanceFilter: 1,
  );

  // ignore: unused_local_variable
  StreamSubscription<Position> positionStream =
      Geolocator.getPositionStream(locationSettings: locationSettings)
          .listen((Position? position) {
    Location.add(position!);
    AltitudeA.add(position.altitude);
    double PAltitude = AltitudeA.elementAt(AltitudeA.length - 2);
    double diff = position.altitude - PAltitude;
    altimeter += diff;
    previousPosition = Location.elementAt(Location.length - 2);
    double distanceD = calculateDistance(previousPosition.latitude,
        previousPosition.longitude, position.latitude, position.longitude);

    FinalDistance = FinalDistance + distanceD;
    int speed = position.speed.round();
    double altitude = position.altitude;
    double Pdistance = FinalDistance - distanceD;
    double gradientF = Calcgradient(Pdistance, distanceD, PAltitude, altitude);
    speedR = speed.toString();
    print("Speed:" + speedR);
    print("Current Distance: " + position.altitude.toString());
    print("Current Gradient: " + gradientF.toString());
    print("AI Speed: " + FSpeed.toString());
    print("AI Distance: " + AD.toString());
    print("AI Gradient: " + gradient.toString());
  });
}

TimeTaken() {
  // ignore: unused_local_variable
  DateTime InitalTime = DateTime.now();
}

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 1000 * 12742 * asin(sqrt(a));
}

double Calcgradient(x1, x2, y1, y2) {
  double y = 0;
  double x = 0;
  double G = 0;
  y = y2 - y1;
  x = x2 - x1;
  G = y / x;
  return G;
}
