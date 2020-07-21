import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';

part 'AddressModel.g.dart';

@HiveType(typeId: 0)
class AddressModel {
  @HiveField(0)
  String formatedAddress;
  @HiveField(1)
  String shortAddress;
  @HiveField(2)
  LatLng latLng;

  AddressModel({
    @required this.formatedAddress,
    @required this.shortAddress,
    @required this.latLng,
  });
}
