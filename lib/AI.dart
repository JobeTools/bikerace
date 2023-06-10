// ignore_for_file: file_names, non_constant_identifier_names, prefer_const_declarations,

import 'dart:async';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'DistanceCalculation.dart';

BasicRacingComputer() async {
  
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 1,
  );
  double SystemMass = 95;
  double FakeSpeed = 5;
  double g = 9.81;
  double gradient = 0;
  double POWER = 0;
  double POWER2 = 0;
  double FSpeed = 5;
  double ratio = 0;

  // ignore: unused_local_variable
  StreamSubscription<Position> positionStream =
      Geolocator.getPositionStream(locationSettings: locationSettings)
          .listen((Position? position) {
            Random random = new Random();
            int randomNumber = random.nextInt(8) + 0; 
            gradient = randomNumber/100;
            POWER = g*gradient*SystemMass*FakeSpeed;
            POWER2 = g*0.005*SystemMass*FakeSpeed;
            ratio = POWER2/POWER;
            FSpeed = FakeSpeed - FakeSpeed*ratio;
            print(FSpeed);











        });
}
