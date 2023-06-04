// ignore_for_file: file_names, non_constant_identifier_names, prefer_const_declarations,

import 'dart:async';
import 'package:geolocator/geolocator.dart';

determinePositionAI() async {
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 1,
  );
  // ignore: unused_local_variable
  StreamSubscription<Position> positionStream =
      Geolocator.getPositionStream(locationSettings: locationSettings)
          .listen((Position? position) {});
}
