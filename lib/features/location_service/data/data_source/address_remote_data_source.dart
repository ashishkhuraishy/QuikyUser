import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quiky_user/features/location_service/data/model/address_model.dart';

abstract class AddressRemoteDataSource {
  Future<AddressModel> getAddress(LatLng latLng);
}
