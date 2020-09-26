import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiky_user/features/cart/domain/entity/cart_item.dart';

class Order extends Equatable {
  final int id;
  final List<CartItem> items;
  final String total;
  final String subTotal;
  final String delCharges;
  final String taxtotal;
  final String discountAmount;
  final String coupon;
  final String status;
  final String paymentType;
  final String deliveryStaus;
  final String vendorStaus;
  final DateTime timeStamp;
  final String otp;
  final String razorPayId;
  final String paymentStatus;

  Order({
    @required this.id,
    @required this.items,
    @required this.total,
    @required this.subTotal,
    @required this.delCharges,
    @required this.taxtotal,
    @required this.discountAmount,
    @required this.coupon,
    @required this.status,
    @required this.paymentType,
    @required this.deliveryStaus,
    @required this.otp,
    @required this.paymentStatus,
    @required this.razorPayId,
    @required this.timeStamp,
    @required this.vendorStaus,
  });

  @override
  List<Object> get props => [
        id,
        items,
        total,
        subTotal,
        delCharges,
        taxtotal,
        discountAmount,
        coupon,
        status,
        paymentType,
        deliveryStaus,
        otp,
        paymentStatus,
        razorPayId,
        timeStamp,
        vendorStaus,
      ];
}
