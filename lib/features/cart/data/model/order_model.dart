import 'package:flutter/cupertino.dart';
import 'package:quiky_user/features/cart/data/model/cart_item_model.dart';
import 'package:quiky_user/features/cart/domain/entity/cart_item.dart';
import 'package:quiky_user/features/cart/domain/entity/order.dart';

class OrderModel extends Order {
  final int id;
  final List<CartItem> items;
  final String total;
  final String subTotal;
  final String delCharges;
  final String taxtotal;
  final String discountAmount;
  final String coupon;

  OrderModel({
    @required this.id,
    @required this.items,
    @required this.total,
    @required this.subTotal,
    @required this.delCharges,
    @required this.taxtotal,
    @required this.discountAmount,
    @required this.coupon,
  }) : super(
          id: id,
          items: items,
          total: total,
          subTotal: subTotal,
          delCharges: delCharges,
          taxtotal: taxtotal,
          discountAmount: discountAmount,
          coupon: coupon,
        );

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final orderList = json['cart']['cartitem'] ?? [];

    return OrderModel(
      id: json['orderid'] ?? -1,
      items: orderList
          .map<CartItemModel>((e) => CartItemModel.fromJson(e))
          .toList(),
      total: json['cart']['total'].toString() ?? "0.0",
      subTotal: json['cart']['sub_total'].toString() ?? "0.0",
      delCharges: json['cart']['delivery_charges'].toString() ?? "0.0",
      taxtotal: json['cart']['tax_total'].toString() ?? "0.0",
      discountAmount: json['cart']['discount_total'].toString() ?? "0.0",
      coupon: json['cart']['coupon'] ?? "",
    );
  }
}
