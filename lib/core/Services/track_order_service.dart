import 'dart:async';

import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/user/domain/entity/order_details.dart';
import 'package:quiky_user/features/user/domain/usecase/order_status.dart';

import '../../injection_container.dart';

class TrackOrder {
  OrderStatus orderStatus = OrderStatus(sl());
  final int id;

  TrackOrder({this.id});
  StreamSink subscription;

  Stream<OrderDetails> timedCounter() async* {
    OrderDetails orderDetails = OrderDetails(
      orderId: null,
      storeName: null,
      total: null,
      cart: null,
      dateTime: null,
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
