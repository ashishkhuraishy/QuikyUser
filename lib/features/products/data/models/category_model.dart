import 'package:flutter/cupertino.dart';
import 'package:quiky_user/features/products/domain/entity/category.dart';

class CategoryModel extends Category {
  int id;
  String imgUrl;
  String title;
  int userId;

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

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imgUrl = json['image'];
    title = json['title'];
    userId = json['user'];
  }
}
