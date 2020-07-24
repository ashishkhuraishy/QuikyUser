import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Recipie extends Equatable {
  final int id;
  final String title;
  final String imgUrl;
  final List<int> stores;

  Recipie({
    @required this.id,
    @required this.title,
    @required this.imgUrl,
    @required this.stores,
  });

  @override
  List<Object> get props => [id, title, imgUrl, stores];
}
