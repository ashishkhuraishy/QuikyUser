import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Address extends Equatable {
  final String formatedAddress;
  final String shortAddress;
  final LatLng latLng;

  Address({this.latLng, this.formatedAddress, this.shortAddress});

  @override
  List<Object> get props => [formatedAddress, shortAddress, latLng];
}
