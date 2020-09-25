import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geodesy/geodesy.dart' as gd;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quiky_user/Constants/Apikeys.dart';

class MapService {
  final double sourceLat;
  final double sourceLong;
  final double destLat;
  final double destLong;

  MapService({
    @required this.sourceLat,
    @required this.sourceLong,
    @required this.destLat,
    @required this.destLong,
  });

  // Getting the center of the Map
  LatLng get center {
    gd.Geodesy _geodesy = gd.Geodesy();
    gd.LatLng l1 = gd.LatLng(sourceLat, sourceLong);
    gd.LatLng l2 = gd.LatLng(destLat, destLong);

    var center = _geodesy.midPointBetweenTwoGeoPoints(l1, l2);

    return LatLng(center.latitude, center.longitude);
  }

  // getting the polylines for the Map to get the travel dir
  Future<Set<Polyline>> get polylines async {
    PolylinePoints _polylinePoints = PolylinePoints();
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await _polylinePoints.getRouteBetweenCoordinates(
      MapApiKey,
      PointLatLng(
        sourceLat,
        sourceLong,
      ),
      PointLatLng(
        destLat,
        destLong,
      ),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.black,
      points: polylineCoordinates,
      width: 5,
    );

    Set<Polyline> polyLines = Set<Polyline>();
    polyLines.add(polyline);

    return polyLines;
  }

  Set<Marker> get markers {
    BitmapDescriptor descriptor = BitmapDescriptor.defaultMarker;

    MarkerId markerSourceId = MarkerId("Origin");
    MarkerId markerDestId = MarkerId("Destination");

    Marker markerSource = Marker(
      markerId: markerSourceId,
      icon: descriptor,
      position: LatLng(sourceLat, sourceLong),
    );

    Marker markerDest = Marker(
      markerId: markerDestId,
      icon: descriptor,
      position: LatLng(destLat, destLong),
    );

    Set<Marker> markers = Set<Marker>();
    markers.add(markerSource);
    markers.add(markerDest);

    return markers;
  }
}
