import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'cart_item.g.dart';

@HiveType(typeId: 15)
class CartItem extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String price;
  @HiveField(3)
  final bool inStock;
  @HiveField(4)
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

  double get inlineTotal {
    double total = 0.0;
    double p = double.tryParse(this.price) ?? 0.0;
    total = p * this.quantity;
    return total;
  }
}
