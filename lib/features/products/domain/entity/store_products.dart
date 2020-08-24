import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiky_user/features/home/domain/entity/restaurents.dart';
import 'package:quiky_user/features/products/domain/entity/product.dart';

class StoreProducts extends Equatable {
  final List<Product> products;
  final Restaurant restaurant;

  StoreProducts({
    @required this.products,
    @required this.restaurant,
  });

  @override
  List<Object> get props => [products, restaurant];
}
