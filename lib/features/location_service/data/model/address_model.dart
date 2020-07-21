import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quiky_user/features/location_service/domain/entity/address.dart';

class AddressModel extends Address {
  AddressModel({
    @required String formattedAddress,
    @required String shortAddress,
    @required LatLng latLng,
  }) : super(
          formatedAddress: formattedAddress,
          shortAddress: shortAddress,
          latLng: latLng,
        );

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    final lat =
        (json['results'][0]['geometry']['location']['lat'] as num).toDouble();
    final long =
        (json['results'][0]['geometry']['location']['lng'] as num).toDouble();
    return AddressModel(
      formattedAddress: json['results'][0]['formatted_address'],
      shortAddress: json['results'][0]['address_components'][0]['short_name'],
      latLng: LatLng(lat, long),
    );
  }
}
