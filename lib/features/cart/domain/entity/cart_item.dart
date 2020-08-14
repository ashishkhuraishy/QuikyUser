import 'package:flutter/cupertino.dart';

class CartItem {
  final int id;
  final String name;
  final String price;
  final bool inStock;
  final int quantity;

  CartItem({
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.inStock,
    @required this.quantity,
  });
}
