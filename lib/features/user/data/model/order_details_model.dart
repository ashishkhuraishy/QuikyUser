import 'package:quiky_user/features/cart/data/model/order_model.dart';
import 'package:quiky_user/features/cart/domain/entity/order.dart';
import 'package:quiky_user/features/user/domain/entity/order_details.dart';

class OrderDetailsModel extends OrderDetails {
  final String userName;
  final String userAddress;
  final String userMobile;
  final String userLocation;
  final String storeName;
  final String storeAddress;
  final String storeLocation;
  final Order order;

  OrderDetailsModel({
    this.order,
    this.storeAddress,
    this.storeLocation,
    this.storeName,
    this.userAddress,
    this.userLocation,
    this.userMobile,
    this.userName,
  }) : super(
          order: order,
          storeAddress: storeAddress,
          storeLocation: storeLocation,
          storeName: storeName,
          userAddress: userAddress,
          userLocation: userLocation,
          userMobile: userMobile,
          userName: userName,
        );

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsModel(
      order: OrderModel.fromJson(json['order']),
      storeAddress: json['vendor']['address'],
      storeLocation: json['vendor']['location'],
      storeName: json['vendor']['title'],
      userAddress: json['user']['shipping_address'],
      userLocation: json['user']['location'],
      userMobile: json['user']['mobile'],
      userName: json['user']['name'],
    );
  }
}
