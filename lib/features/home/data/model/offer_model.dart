import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:quiky_user/features/home/domain/entity/offer.dart';

part 'offer_model.g.dart';

@HiveType(typeId: 5)
class OfferModel extends Offer {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String code;
  @HiveField(3)
  final String text;
  @HiveField(4)
  final int offerId;
  @HiveField(5)
  final String percentage;

  OfferModel({
    @required this.id,
    @required this.title,
    @required this.code,
    @required this.text,
    @required this.offerId,
    @required this.percentage,
  }) : super(
          id: id,
          title: title,
          code: code,
          text: text,
          offerId: offerId,
          percentage: percentage,
        );

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'],
      title: json['title'] ?? '',
      code: json['code'] ?? '',
      text: json['text'] ?? '',
      offerId: json['offer']['id'],
      percentage: json['offer']['percentage'] ?? '',
    );
  }
}
