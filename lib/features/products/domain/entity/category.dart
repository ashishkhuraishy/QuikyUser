import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:quiky_user/features/products/domain/entity/product.dart';

// ignore: must_be_immutable 
class Category extends Equatable {
  final int id;
  final String imgUrl;
  final String title;
  final int userId;
  final List<Product> produts;

  Category({
    @required this.id,
    @required this.imgUrl,
    @required this.title,
    @required this.userId,
    @required this.produts,
  });

  @override
  List<Object> get props => [id, imgUrl, title, userId,produts];

  // List<Product> produts = [];
  List<Product> get products => produts;

  // addProducts(List<Product> products) {
  //   _produts.addAll(products);
  // }
}
