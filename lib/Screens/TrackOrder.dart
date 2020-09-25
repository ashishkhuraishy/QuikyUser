import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quiky_user/core/Services/track_order_service.dart';
import 'package:quiky_user/features/user/domain/entity/order_details.dart';
import 'package:quiky_user/theme/themedata.dart';

class TrackOrderW extends StatelessWidget {
  TrackOrderW({Key key}) : super(key: key);

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    double scHeight = MediaQuery.of(context).size.height;
    final OrderDetails order = ModalRoute.of(context).settings.arguments;
    TrackOrder trackOrder = new TrackOrder(id: order.orderId, start: [
      double.tryParse(order.vendorLocation.split(",")[0]),
      double.tryParse(order.vendorLocation.split(",")[1])
    ], end: [
      double.tryParse(order.userLocation.split(",")[0]),
      double.tryParse(order.userLocation.split(",")[1]),
    ]);

    
    return Scaffold(
      appBar: AppBar(
        title: Text("Order id: ${order.orderId}",
            style: Theme.of(context).textTheme.headline5),
      ),
      body: Column(
        children: [
          Container(
            height: scHeight / 3 * 2,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                bearing: 0,
                target: LatLng(
                    double.tryParse(order.userLocation.split(",")[0]),
                    double.tryParse(order.userLocation.split(",")[1])),
                tilt: 0,
                zoom: 12,
              ),
              markers: [
                Marker(
                  markerId: MarkerId('1'),
                  position: LatLng(
                      double.tryParse(order.userLocation.split(",")[0]),
                      double.tryParse(order.userLocation.split(",")[1])),
                ),
                Marker(
                  markerId: MarkerId('1'),
                  position: LatLng(
                      double.tryParse(order.vendorLocation.split(",")[0]),
                      double.tryParse(order.vendorLocation.split(",")[1])),
                ),
              ].toSet(),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          Container(
            height: scHeight / 3 - 108,
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
                        "${snapshot.data.status}",
                        style: primaryBold14,
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    return Text("Something went wrong");
                  }
                }),
          )
        ],
      ),
    );
  }
}
