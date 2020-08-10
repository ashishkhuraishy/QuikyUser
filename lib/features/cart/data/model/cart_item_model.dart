import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:quiky_user/features/cart/domain/entity/cart_item.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 4)
class CartItemModel extends CartItem {
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
