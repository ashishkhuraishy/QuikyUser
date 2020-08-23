import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class CartItem extends Equatable {
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

  @override
  List<Object> get props => [
        id,
        name,
        price,
        inStock,
        quantity,
      ];
}
