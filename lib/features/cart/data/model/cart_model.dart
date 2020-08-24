import 'package:flutter/cupertino.dart';

import '../../../home/domain/entity/offer.dart';
import '../../domain/entity/cart.dart';
import '../../domain/entity/cart_item.dart';

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
