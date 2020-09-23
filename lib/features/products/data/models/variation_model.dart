import 'package:flutter/cupertino.dart';
import 'package:quiky_user/features/products/domain/entity/variation.dart';

class VariationModel extends Variation {
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

  VariationModel({
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
  }) : super(
          id: id,
          image: image,
          title: title,
          color: color,
          weight: weight,
          size: size,
          isStock: isStock,
          price: price,
          quantity: quantity,
          updated: updated,
          active: active,
          productId: productId,
        );

  factory VariationModel.fromJson(Map<String, dynamic> json) {
    return VariationModel(
      id: json['id'],
      image: json['image'] ?? '',
      title: json['title'] ?? '',
      color: json['color'] ?? '',
      weight: json['weight'] ?? '',
      size: json['size'] ?? '',
      isStock: json['is_stock'] ?? false,
      price: '${json['price']}' ?? '0',
      quantity: "${json['quantity']}" ?? '',
      updated: json['updated'] ?? '',
      active: json['active'] ?? false,
      productId: json['product'] ?? -1,
    );
  }
}
