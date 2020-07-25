import 'package:flutter/cupertino.dart';
import 'package:quiky_user/features/products/domain/entity/category.dart';

class CategoryModel extends Category {
  final int id;
  final String imgUrl;
  final String title;
  final int userId;

  CategoryModel({
    @required this.id,
    @required this.imgUrl,
    @required this.title,
    @required this.userId,
  }) : super(
          id: id,
          imgUrl: imgUrl,
          title: title,
          userId: userId,
        );

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      imgUrl: json['image'],
      title: json['title'],
      userId: json['user'],
    );
  }
}
