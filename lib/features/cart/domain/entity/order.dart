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

  Order({
    @required this.id,
    @required this.items,
    @required this.total,
    @required this.subTotal,
    @required this.delCharges,
    @required this.taxtotal,
    @required this.discountAmount,
    @required this.coupon,
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
      ];
}
