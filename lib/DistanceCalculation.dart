import 'dart:async';
import 'dart:math';
import 'package:geolocator/geolocator.dart';

List<Position> Location = [];
List<double> SpeedA = [];
String long = "", lat = "", distance = "";
determinePosition() async {
  DateTime StartTime = DateTime.now();
  Position _previousPosition;
  double FinalDistance = 0;
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 1,
  );

  // ignore: unused_local_variable
  StreamSubscription<Position> positionStream =
      Geolocator.getPositionStream(locationSettings: locationSettings)
          .listen((Position? position) {
    Location.add(position!);
    _previousPosition = Location.elementAt(Location.length - 2);
    double distanceD = calculateDistance(_previousPosition.latitude,
        _previousPosition.longitude, position.latitude, position.longitude);
    FinalDistance = FinalDistance + distanceD;
    double time = StartTime.difference(DateTime.now()).inSeconds * -1;
    StartTime = DateTime.now();
    double speed = distanceD / time;
    int Rspeed = speed.round();
    print(Rspeed);
  });
}

TimeTaken() {
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
