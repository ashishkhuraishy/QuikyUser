import 'package:equatable/equatable.dart';

class Offer extends Equatable {
  final int id;
  final String title;
  final String code;
  final String text;
  final int offerId;
  final String percentage;

  Offer({
    this.id,
    this.title,
    this.code,
    this.text,
    this.offerId,
    this.percentage,
  });

  @override
  List<Object> get props => [id, title, code, text, offerId, percentage];
}
