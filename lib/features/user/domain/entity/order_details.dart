import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiky_user/features/cart/domain/entity/cart.dart';

class OrderDetails extends Equatable {
  final int orderId;
  final String storeName;
  final String total;
  final Cart cart;
  final DateTime dateTime;
  final String userLocation;
  final String status;
  final String shippingAddress;
  final String vendorStatus;
  final String vendorLocation;
  final String paymentAmount;
  final String paymentType;
  final String subTotal;
  final String taxTotal;
  final String deliveryDate;
  final String deliveryStatus;
  final int deliveryIncentative;

  OrderDetails({
    @required this.orderId,
    @required this.storeName,
    @required this.total,
    @required this.cart,
    @required this.dateTime,
    @required this.userLocation,
    @required this.status,
    @required this.shippingAddress,
    @required this.vendorStatus,
    @required this.paymentAmount,
    @required this.paymentType,
    @required this.deliveryDate,
    @required this.subTotal,
    @required this.taxTotal,
    @required this.deliveryStatus,
    @required this.deliveryIncentative,
    @required this.vendorLocation,
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
