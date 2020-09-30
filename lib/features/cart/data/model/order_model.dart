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
  final String status;
  final String paymentType;
  final String deliveryStaus;
  final String vendorStaus;
  final DateTime timeStamp;
  final String otp;
  final String razorPayId;
  final String paymentStatus;

  OrderModel({
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
  }) : super(
          id: id,
          items: items,
          total: total,
          subTotal: subTotal,
          delCharges: delCharges,
          taxtotal: taxtotal,
          discountAmount: discountAmount,
          coupon: coupon,
          status: status,
          paymentType: paymentType,
          deliveryStaus: deliveryStaus,
          otp: otp,
          paymentStatus: paymentStatus,
          razorPayId: razorPayId,
          timeStamp: timeStamp,
          vendorStaus: vendorStaus,
        );

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final orderList = json['cart']['cartitem'] ?? [];

    return OrderModel(
      id: json['id'] ?? -1,
      items: orderList
          .map<CartItemModel>((e) => CartItemModel.fromJson(e))
          .toList(),
      total: json['cart']['total'].toStringAsFixed(2) ?? "0.0",
      subTotal: json['cart']['sub_total'].toStringAsFixed(2) ?? "0.0",
      delCharges: json['cart']['delivery_charges'].toStringAsFixed(2) ?? "0.0",
      taxtotal: json['cart']['tax_total'].toStringAsFixed(2) ?? "0.0",
      discountAmount:
          json['cart']['discount_total'].toStringAsFixed(2) ?? "0.0",
      coupon: json['cart']['coupon'] ?? "",
      status: json['status'] ?? '',
      paymentType: json['payment_type'] ?? '',
      deliveryStaus: json['delivery_status'] ?? '',
      otp: json['otp'] ?? '',
      paymentStatus: json['payment_status'] ?? '',
      razorPayId: json['razorpay_order_id'] ?? '',
      timeStamp: json['timestamp'] != null
          ? DateTime.tryParse(json['timestamp'])
          : DateTime.now(),
      vendorStaus: json['vendor_status'],
    );
  }
}
