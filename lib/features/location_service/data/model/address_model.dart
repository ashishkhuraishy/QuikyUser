import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:quiky_user/features/location_service/domain/entity/address.dart';

part 'address_model.g.dart';

@HiveType(typeId: 6)
class AddressModel extends Address {
  @HiveField(0)
  final String formattedAddress;
  @HiveField(1)
  final String shortAddress;
  @HiveField(2)
  final double lat;
  @HiveField(3)
  final double long;

  AddressModel({
    @required this.formattedAddress,
    @required this.shortAddress,
    @required this.lat,
    @required this.long,
  }) : super(
          formattedAddress: formattedAddress,
          shortAddress: shortAddress,
          lat: lat,
          long: long,
        );

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      formattedAddress: json['results'][0]['formatted_address'],
      shortAddress: json['results'][0]['address_components'][0]['short_name'],
      lat:
          (json['results'][0]['geometry']['location']['lat'] as num).toDouble(),
      long:
          (json['results'][0]['geometry']['location']['lng'] as num).toDouble(),
    );
  }
}
