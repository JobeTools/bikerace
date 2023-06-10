// ignore_for_file: file_names, non_constant_identifier_names, prefer_const_declarations,

import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'DistanceCalculation.dart';

BasicRacingComputer() async {
  
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 1,
  );
  double FakeDistance = 0;
  DateTime InitalTime = DateTime.now();
  double SpeedDecrease= 0;
  double rr = 0.005;
  double SystemMass = 95;
  double FakeSpeed = 0;
  double windCoe = 0.5;
  double AOB = 0.6;
  double FakeSpeedA = 0;
  double AirDensity = 1.226;
  double g = 9.81;
  double gradient = 0;
  double POWER = 0;
  double POWER2 = 0;
  double ratio = 0;

  // ignore: unused_local_variable
  StreamSubscription<Position> positionStream =
      Geolocator.getPositionStream(locationSettings: locationSettings)
          .listen((Position? position) {
            POWER = rr*SystemMass*FakeSpeed +windCoe*AOB*FakeSpeed*(FakeSpeedA*FakeSpeedA)*AirDensity + g*gradient*SystemMass*FakeSpeed;
            POWER2 = rr*SystemMass*FakeSpeed +windCoe*AOB*FakeSpeed*(FakeSpeedA*FakeSpeedA)*AirDensity;
            ratio = POWER/POWER2;
            print(ratio);











        });
}
