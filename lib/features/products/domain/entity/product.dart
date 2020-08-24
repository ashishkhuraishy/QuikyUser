import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'category.dart';
import 'variation.dart';

class Product extends Equatable {
  final int id;
  final List<String> productImages;
  final List<Variation> variations;
  final List<String> productReviews;
  final List<String> productViews;
  final Category category;
  final String image;
  final String title;
  final String sku;
  final String tax;
  final String description;
  final int quantity;
  final String discount;
  final bool isStock;
  final bool isFeatured;
  final bool isDiscount;
  final String vegNvEgg;
  final bool active;
  final String timestamp;
  final String updated;
  final int user;
  final String filter;

  Product({
    @required this.id,
    @required this.productImages,
    @required this.variations,
    @required this.productReviews,
    @required this.productViews,
    @required this.category,
    @required this.image,
    @required this.title,
    @required this.sku,
    @required this.tax,
    @required this.description,
    @required this.quantity,
    @required this.discount,
    @required this.isStock,
    @required this.isFeatured,
    @required this.isDiscount,
    @required this.vegNvEgg,
    @required this.active,
    @required this.timestamp,
    @required this.updated,
    @required this.user,
    @required this.filter,
  });

  @override
  List<Object> get props => [
        id,
        productImages,
        variations,
        productReviews,
        productViews,
        category,
        image,
        title,
        sku,
        tax,
        description,
        quantity,
        discount,
        isStock,
        isFeatured,
        isDiscount,
        vegNvEgg,
        active,
        timestamp,
        updated,
        user,
        filter,
      ];
}
