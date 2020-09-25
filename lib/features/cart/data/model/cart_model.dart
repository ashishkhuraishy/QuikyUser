import 'package:flutter/cupertino.dart';
import 'package:quiky_user/features/cart/data/model/cart_item_model.dart';

import '../../../home/domain/entity/offer.dart';
import '../../domain/entity/cart.dart';
import '../../domain/entity/cart_item.dart';

class CartModel extends Cart {
  final int storeId;
  final String storeName;
  final String storeAddress;
  final String storeImage;
  final String storeLogo;
  final List<Offer> offers;
  final List<CartItem> cartItems;

  CartModel({
    @required this.storeId,
    @required this.storeName,
    @required this.storeAddress,
    @required this.storeImage,
    @required this.offers,
    @required this.cartItems,
    @required this.storeLogo,
  }) : super(
          storeId: storeId,
          offers: offers,
          cartItems: cartItems,
          storeName: storeName,
          storeAddress: storeAddress,
          storeImage: storeImage,
          storeLogo: storeLogo,
        );

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      storeId: int.tryParse(json['store_id']),
      storeName: json['store_name'] ?? '',
      storeAddress: json['store_address'] ?? '',
      storeImage: json['store_image'] ?? '',
      offers: json['offers'] ?? [],
      cartItems: json['cartitem']
          .map<CartItem>((e) => CartItemModel.fromJson(e))
          .toList(),
      storeLogo: json['store_logo'] ?? '',
    );
  }
}
