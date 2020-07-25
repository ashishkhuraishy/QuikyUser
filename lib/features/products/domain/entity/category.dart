import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Category extends Equatable {
  final int id;
  final String imgUrl;
  final String title;
  final int userId;

  Category({
    @required this.id,
    @required this.imgUrl,
    @required this.title,
    @required this.userId,
  });

  @override
  List<Object> get props => [id, imgUrl, title, userId];
}
