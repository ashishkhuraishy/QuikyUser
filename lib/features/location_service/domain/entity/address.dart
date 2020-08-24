import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'address.g.dart';

@HiveType(typeId: 10)
class Address extends Equatable {
  @HiveField(0)
  final String formattedAddress;
  @HiveField(1)
  final String shortAddress;
  @HiveField(2)
  final double lat;
  @HiveField(3)
  final double long;

  Address({
    @required this.lat,
    @required this.long,
    @required this.formattedAddress,
    @required this.shortAddress,
  });

  @override
  List<Object> get props => [formattedAddress, shortAddress, lat, long];
}
