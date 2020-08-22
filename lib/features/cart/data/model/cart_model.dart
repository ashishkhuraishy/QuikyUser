import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:quiky_user/features/cart/data/model/cart_item_model.dart';
import 'package:quiky_user/features/cart/domain/entity/cart.dart';
import 'package:quiky_user/features/home/data/model/offer_model.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 3)
class CartModel extends Cart {
  @HiveField(0)
  final int storeId;
  @HiveField(1)
  final List<OfferModel> offers;
  @HiveField(2)
  final List<CartItemModel> cartItems;

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
