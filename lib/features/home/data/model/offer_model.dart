import 'package:flutter/cupertino.dart';
import 'package:quiky_user/features/home/domain/entity/offer.dart';

class OfferModel extends Offer {
  final int id;
  final String title;
  final String code;
  final String text;
  final int offerId;
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
