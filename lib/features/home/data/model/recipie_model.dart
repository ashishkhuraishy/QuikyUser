import 'package:flutter/foundation.dart';
import 'package:quiky_user/features/home/domain/entity/recipie.dart';

class RecipieModel extends Recipie {
  final int id;
  final String title;
  final String imgUrl;
  final List<int> stores;

  RecipieModel({
    @required this.id,
    @required this.title,
    @required this.imgUrl,
    @required this.stores,
  }) : super(
          id: id,
          title: title,
          imgUrl: imgUrl,
          stores: stores,
        );

  factory RecipieModel.fromJson(Map<String, dynamic> json) {
    return RecipieModel(
      id: json['id'],
      title: json['title'],
      imgUrl: json['image'],
      stores: json['stores'].map<int>((e) => e as int).toList(),
    );
  }
}
