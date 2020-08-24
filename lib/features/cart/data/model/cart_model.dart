import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:quiky_user/features/cart/data/model/cart_item_model.dart';
import 'package:quiky_user/features/cart/domain/entity/cart.dart';
import 'package:quiky_user/features/cart/domain/entity/cart_item.dart';
import 'package:quiky_user/features/home/domain/entity/offer.dart';

class CartModel extends Cart {
  final int storeId;
  final List<Offer> offers;
  final List<CartItem> cartItems;

  CartModel({
    @required this.storeId,
    @required this.offers,
    @required this.cartItems,
  }) : super(
          storeId: storeId,
          offers: offers,
          cartItems: cartItems,
        );
}
