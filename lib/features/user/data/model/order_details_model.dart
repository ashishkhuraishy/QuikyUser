import 'package:quiky_user/features/cart/data/model/cart_model.dart';
import 'package:quiky_user/features/cart/domain/entity/cart.dart';
import 'package:quiky_user/features/user/domain/entity/order_details.dart';

class OrderDetailsModel extends OrderDetails {
  final int id;
  final Cart cart;
  final String store;
  final String deliveryId;
  final String orderid;
  final String userLocation;
  final String shippingAddress;
  final String subTotal;
  final String taxTotal;
  final String coupon;
  final String discountTotal;
  final String finalTotal;
  final int delivereyCharges;
  final String status;
  final String paymentType;
  final String deliveryStatus;
  final String vendorStatus;
  final String statusNotes;
  final String timestamp;
  final String otp;
  final String updated;
  final bool bulkOrder;
  final bool milkOrder;
  final String deliveryDate;
  final int deliveryIncentative;
  final String txnToken;
  final String otherCharges;
  final String paymentId;
  final String paymentStatus;
  final String paymentAmount;
  final String userId;
  final String userName;
  final String userMobile;
  final String vendorName;
  final String vendorLocation;
  final String vendorAddress;

  OrderDetailsModel({
    this.id,
    this.cart,
    this.store,
    this.deliveryId,
    this.orderid,
    this.userLocation,
    this.shippingAddress,
    this.subTotal,
    this.taxTotal,
    this.coupon,
    this.discountTotal,
    this.finalTotal,
    this.delivereyCharges,
    this.status,
    this.paymentType,
    this.deliveryStatus,
    this.vendorStatus,
    this.statusNotes,
    this.timestamp,
    this.otp,
    this.updated,
    this.bulkOrder,
    this.milkOrder,
    this.deliveryDate,
    this.deliveryIncentative,
    this.txnToken,
    this.otherCharges,
    this.paymentId,
    this.paymentStatus,
    this.paymentAmount,
    this.userId,
    this.userMobile,
    this.userName,
    this.vendorAddress,
    this.vendorLocation,
    this.vendorName,
  }) : super(
            orderId: id,
            storeName: vendorName,
            total: finalTotal,
            cart: cart,
            dateTime: DateTime.parse(timestamp),
            userLocation: userLocation,
            status: status,
            shippingAddress: shippingAddress,
            vendorStatus: vendorStatus,
            paymentAmount: paymentAmount,
            paymentType: paymentType,
            subTotal: taxTotal,
            taxTotal: taxTotal,
            deliveryDate: deliveryDate,
            deliveryStatus: deliveryStatus,
            deliveryIncentative: deliveryIncentative,
            vendorLocation: vendorLocation);

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsModel(
      id: json['id'],
      cart: json['cart'] != null ? new CartModel.fromJson(json['cart']) : null,
      store: json['store'],
      deliveryId: json['delivery_id'],
      orderid: json['orderid'],
      userLocation: json['user_location'],
      shippingAddress: json['shipping_address'],
      subTotal: "${json['sub_total']}",
      taxTotal:
          "${json['tax_total'] != null ? json['tax_total'].toStringAsFixed(2) : 0}",
      coupon: json['coupon'],
      discountTotal: "${json['discount_total']}",
      finalTotal: "${json['final_total']}",
      delivereyCharges: json['deliverey_charges'],
      status: json['status'],
      paymentType: json['payment_type'],
      deliveryStatus: json['delivery_status'],
      vendorStatus: json['vendor_status'],
      statusNotes: json['status_notes'],
      timestamp: json['timestamp'] ??
          DateTime.now().toIso8601String(), // TODO : Edit this
      otp: json['otp'],
      updated: json['updated'],
      bulkOrder: json['bulk_order'],
      milkOrder: json['milk_order'],
      deliveryDate: json['delivery_date'],
      deliveryIncentative: json['delivery_incentative'],
      txnToken: json['txnToken'],
      otherCharges: json['other_charges'],
      paymentId: json['payment_id'],
      paymentStatus: json['payment_status'],
      paymentAmount: json['payment_amount'],
      userId: "${json['user']['id']}" ?? '',
      userName: json['user']['name'] ?? '',
      userMobile: json['user']['mobile'] ?? '',
      vendorName: json['vendor']['title'] ?? '',
      vendorLocation: json['vendor']['location'] ?? '',
      vendorAddress: json['vendor']['address'] ?? '',
    );
  }
}
