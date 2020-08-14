import 'package:flutter/cupertino.dart';
import 'package:quiky_user/features/cart/domain/entity/cart_item.dart';
import 'package:quiky_user/features/home/domain/entity/offer.dart';

class Cart {
  final int storeId;
  final List<Offer> offers;
  final List<CartItem> cartItems;

  Cart({
    @required this.storeId,
    @required this.offers,
    @required this.cartItems,
  });
}
