import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiky_user/features/cart/domain/entity/cart.dart';

class OrderDetails extends Equatable {
  final int orderId;
  final String storeName;
  final String total;
  final Cart cart;
  final DateTime dateTime;

  OrderDetails({
    @required this.orderId,
    @required this.storeName,
    @required this.total,
    @required this.cart,
    @required this.dateTime,
  });

  @override
  List<Object> get props => [
        orderId,
        storeName,
        cart,
        dateTime,
        total,
      ];
}
