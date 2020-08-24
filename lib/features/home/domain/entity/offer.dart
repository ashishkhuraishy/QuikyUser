import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'offer.g.dart';

@HiveType(typeId: 13)
class Offer extends Equatable {
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
