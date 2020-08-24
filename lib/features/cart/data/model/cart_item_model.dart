import 'package:flutter/cupertino.dart';
import 'package:quiky_user/features/cart/domain/entity/cart_item.dart';

class CartItemModel extends CartItem {
  final int id;
  final String name;
  final String price;
  final bool inStock;
  final int quantity;

  CartItemModel({
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.inStock,
    @required this.quantity,
  }) : super(
          id: id,
          name: name,
          price: price,
          inStock: inStock,
          quantity: quantity,
        );
}
