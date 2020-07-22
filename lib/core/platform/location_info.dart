import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

abstract class LocationInfo {
  Future<LatLng> get currentLocation;
  Future<bool> get locationPermission;
}

class LocationInfoImpl extends LocationInfo {
  final Location location;
  LocationInfoImpl({@required this.location});

  @override
  Future<LatLng> get currentLocation async {
    LocationData locationData = await location.getLocation();

    return LatLng(locationData.latitude, locationData.longitude);
  }

  @override
  Future<bool> get locationPermission async {
    PermissionStatus _permissionStatus = await location.hasPermission();
    bool _serviceStatus = await location.serviceEnabled();

    if (!_serviceStatus) {
      _serviceStatus = await location.requestService();
    }

    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await location.requestPermission();
    }

    if (_permissionStatus == PermissionStatus.granted && _serviceStatus) {
      return true;
    }
    return false;
  }
}
