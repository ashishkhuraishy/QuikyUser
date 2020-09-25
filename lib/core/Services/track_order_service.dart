import 'dart:async';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:quiky_user/Constants/Apikeys.dart';
import 'package:quiky_user/features/cart/domain/entity/order.dart';
import 'package:quiky_user/features/user/domain/entity/order_details.dart';
import 'package:quiky_user/features/user/domain/usecase/order_status.dart';

import '../../injection_container.dart';

class TrackOrder {
  OrderStatus orderStatus = OrderStatus(sl());
  final int id;

  TrackOrder({this.id, this.start, this.end});

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
      order: Order(
        id: null,
        items: [],
        total: null,
        subTotal: null,
        delCharges: null,
        taxtotal: null,
        discountAmount: null,
        coupon: null,
        status: null,
        paymentType: null,
        deliveryStaus: null,
        otp: null,
        paymentStatus: null,
        razorPayId: null,
        timeStamp: null,
        vendorStaus: null,
      ),
      storeAddress: null,
      storeLocation: null,
      storeName: null,
      userAddress: null,
      userLocation: null,
      userMobile: null,
      userName: null,
    );

    while (true) {
      await Future.delayed(Duration(seconds: 10));
      final result = await orderStatus(id);
      result.fold(
        (failure) => print(failure),
        (orderDtils) {
          print(orderDetails.order.id);
          orderDetails = orderDtils;
        },
      );
      yield orderDetails;
    }
  }
}
