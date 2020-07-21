import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

abstract class LocationInfo {
  Future<LatLng> get currentLocation;
  Future<bool> get locationPermission;
}

class LocationData extends LocationInfo {
  final Location location;
  LocationData(this.location);

  /*bool _serviceEnabled;
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

_locationData = await location.getLocation(); */

  @override
  // TODO: implement currentLocation
  Future<LatLng> get currentLocation => throw UnimplementedError();

  @override
  // TODO: implement locationPermission
  Future<bool> get locationPermission => throw UnimplementedError();
}
