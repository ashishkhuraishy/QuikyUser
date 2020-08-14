import 'package:flutter/cupertino.dart';
import 'package:quiky_user/features/products/domain/entity/category.dart';
import 'package:quiky_user/features/products/domain/entity/product.dart';

// ignore: must_be_immutable
class CategoryModel extends Category {
  final int id;
  final String imgUrl;
  final String title;
  final int userId;
  final List<Product> produts;

  CategoryModel({
    @required this.id,
    @required this.imgUrl,
    @required this.title,
    @required this.userId,
    @required this.produts,
  }) : super(
          id: id,
          imgUrl: imgUrl,
          title: title,
          userId: userId,
          produts: produts,
        );

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      imgUrl: json['image'],
      title: json['title'],
      userId: json['user'],
      produts: [],
    );
  }
}
