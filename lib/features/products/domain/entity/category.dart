import 'package:flutter/foundation.dart';

class Category {
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
}
