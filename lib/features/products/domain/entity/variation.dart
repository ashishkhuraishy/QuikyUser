import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Variation extends Equatable {
  final int id;
  final String image;
  final String title;
  final String color;
  final String weight;
  final String size;
  final bool isStock;
  final String price;
  final String quantity;
  final String updated;
  final bool active;
  final int productId;

  Variation({
    @required this.id,
    @required this.image,
    @required this.title,
    @required this.color,
    @required this.weight,
    @required this.size,
    @required this.isStock,
    @required this.price,
    @required this.quantity,
    @required this.updated,
    @required this.active,
    @required this.productId,
  });

  @override
  List<Object> get props => [
        id,
        image,
        title,
        color,
        weight,
        size,
        isStock,
        price,
        quantity,
        updated,
        active,
        productId,
      ];
}
