import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quiky_user/core/Services/MapService.dart';
import 'package:quiky_user/core/Services/track_order_service.dart';
import 'package:quiky_user/features/user/domain/entity/order_details.dart';
import 'package:quiky_user/theme/themedata.dart';

class TrackOrderW extends StatefulWidget {
  final OrderDetails orderdetails;

  TrackOrderW({this.orderdetails, Key key}) : super(key: key);

  @override
  _TrackOrderWState createState() => _TrackOrderWState();
}

class _TrackOrderWState extends State<TrackOrderW> {
  final Completer<GoogleMapController> _controller = Completer();
  MapService mapService;
  bool loading = true;

  TrackOrder trackOrder;

  LatLng center = LatLng(0, 0);
  Set<Polyline> polylines = Set();
  Set<Marker> markers = Set();

  @override
  void initState() {
    super.initState();

    List<double> source = [
      double.tryParse(widget.orderdetails.storeLocation.split(",")[0]),
      double.tryParse(widget.orderdetails.storeLocation.split(",")[1])
    ];
    List<double> dest = [
      double.tryParse(widget.orderdetails.userLocation.split(",")[0]),
      double.tryParse(widget.orderdetails.userLocation.split(",")[1]),
    ];

    trackOrder = TrackOrder(
      id: widget.orderdetails.order.id,
      start: source,
      end: dest,
    );

    initAll(source, dest);
  }

  initAll(List<double> ss, List<double> des) async {
    mapService = MapService(
      sourceLat: ss[0],
      sourceLong: ss[1],
      destLat: des[0],
      destLong: des[1],
    );

    center = mapService.center;
    polylines = await mapService.polylines;
    markers = mapService.markers;

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double scHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Order id: ${widget.orderdetails.order.id}",
            style: Theme.of(context).textTheme.headline5),
      ),
      body: Column(
        children: [
          Container(
            height: scHeight / 3 * 2,
            child: !loading
                ? GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      bearing: 0,
                      target: center,
                      tilt: 0,
                      zoom: 12,
                    ),
                    markers: markers,
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                      Factory<OneSequenceGestureRecognizer>(
                        () => EagerGestureRecognizer(),
                      ),
                    ].toSet(),
                    polylines: polylines,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  )
                : Container(child: Center(child: CircularProgressIndicator())),
          ),
          Container(
            width: double.infinity,
            height: scHeight / 3 - 110,
            margin: EdgeInsets.all(10),
            decoration:
                BoxDecoration(border: Border.all(color: primary, width: 3)),
            padding: EdgeInsets.all(30),
            child: StreamBuilder<OrderDetails>(
              stream: trackOrder.timedCounter(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                } else if (snapshot.hasError) {
                  return Text("Error ${snapshot.error}");
                } else if (snapshot.hasData) {
                  return Center(
                    child: Text(
                      "${snapshot.data.order.status}",
                      style: primaryBold14,
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return Text("Something went wrong");
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
