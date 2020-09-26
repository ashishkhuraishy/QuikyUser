import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiky_user/features/cart/domain/entity/order.dart';

class OrderDetails extends Equatable {
  final String userName;
  final String userAddress;
  final String userMobile;
  final String userLocation;
  final String storeName;
  final String storeAddress;
  final String storeLocation;
  final Order order;

  OrderDetails({
    @required this.order,
    @required this.storeAddress,
    @required this.storeLocation,
    @required this.storeName,
    @required this.userAddress,
    @required this.userLocation,
    @required this.userMobile,
    @required this.userName,
  });

  @override
  List<Object> get props => [
        order,
        storeAddress,
        storeLocation,
        storeName,
        userAddress,
        userLocation,
        userMobile,
        userName,
      ];
}
