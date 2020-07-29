import 'package:flutter/foundation.dart';
import 'package:quiky_user/features/home/data/model/restaurant_model.dart';
import 'package:quiky_user/features/products/data/models/product_model.dart';

import '../../../home/domain/entity/restaurents.dart';
import '../../domain/entity/product.dart';
import '../../domain/entity/store_products.dart';

class StoreProductsModel extends StoreProducts {
  final List<Product> products;
  final Restaurant restaurant;

  StoreProductsModel({
    @required this.products,
    @required this.restaurant,
  }) : super(
          products: products,
          restaurant: restaurant,
        );

  factory StoreProductsModel.fromJson(Map<String, dynamic> json) {
    return StoreProductsModel(
      products: json['products']
          .map<ProductModel>((e) => ProductModel.fromJson(e))
          .toList(),
      restaurant: RestaurantModel.fromJson(json['store_detail']),
    );
  }
}
