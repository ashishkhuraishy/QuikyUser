import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:quiky_user/Constants/Apikeys.dart';
import 'package:quiky_user/core/error/exception.dart';
import 'package:quiky_user/features/location_service/data/model/address_model.dart';

abstract class AddressRemoteDataSource {
  /// Get data from the google Api and return the parsed [AddressModel]
  /// data or throws [ServerException] on failure
  Future<AddressModel> getAddress(LatLng latLng);
}

class AddressRemoteDataSourceImpl extends AddressRemoteDataSource {
  final Client client;

  AddressRemoteDataSourceImpl({@required this.client});

  @override
  Future<AddressModel> getAddress(LatLng latLng) async {
    Response response =
        await client.get(GMapURL + '${latLng.latitude},${latLng.longitude}');
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return AddressModel.fromJson(body);
    } else
      throw ServerException();
  }
}
