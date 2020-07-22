import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Address extends Equatable {
  final String formattedAddress;
  final String shortAddress;
  final double lat;
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
