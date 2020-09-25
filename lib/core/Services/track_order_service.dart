import 'dart:async';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:quiky_user/Constants/Apikeys.dart';
import 'package:quiky_user/features/user/domain/entity/order_details.dart';
import 'package:quiky_user/features/user/domain/usecase/order_status.dart';

import '../../injection_container.dart';

class TrackOrder {
  OrderStatus orderStatus = OrderStatus(sl());
  final int id;

  TrackOrder({this.id,this.start,this.end});

  PolylinePoints polylinePoints = PolylinePoints();
  List<double> start, end;

  Future<List<PointLatLng>> getPolyLines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      MapApiKey,
      PointLatLng(start[0], start[1]),
      PointLatLng(end[0], end[1]),
      travelMode: TravelMode.driving,
    );
    print(result.points);
    return result.points;
  }

  Stream<OrderDetails> timedCounter() async* {
    OrderDetails orderDetails = OrderDetails(
      orderId: null,
      storeName: null,
      total: null,
      cart: null,
      dateTime: null,
      userLocation: null,
      deliveryDate: null,
      deliveryIncentative: null,
      deliveryStatus: null,
      paymentAmount: null,
      paymentType: null,
      shippingAddress: null,
      status: null,
      subTotal: null,
      taxTotal: null,
      vendorLocation: null,
      vendorStatus: null,
    );

    while (true) {
      await Future.delayed(Duration(seconds: 10));
      final result = await orderStatus(id);
      result.fold(
        (failure) => print(failure),
        (orderStatus) => orderDetails = orderStatus,
      );
      yield orderDetails;
    }
  }
}
