import 'package:location/location.dart';

optimal() async {
Location location = new Location();

bool _serviceEnabled;
PermissionStatus _permissionGranted;
LocationData _locationData;

_serviceEnabled = await location.serviceEnabled();
if (!_serviceEnabled) {
  _serviceEnabled = await location.requestService();
  if (!_serviceEnabled) {
    return;
  }
}

_permissionGranted = await location.hasPermission();
if (_permissionGranted == PermissionStatus.denied) {
  _permissionGranted = await location.requestPermission();
  if (_permissionGranted != PermissionStatus.granted) {
    return;
  }
}

_locationData = await location.getLocation();

location.onLocationChanged.listen((LocationData currentLocation) {
  print(currentLocation.altitude); // In meters above the WGS 84 reference ellipsoid
  print(currentLocation.speed); // In meters/second

  
});


}