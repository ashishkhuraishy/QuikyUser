import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:quiky_user/features/location_service/data/model/address_model.dart';
import 'package:quiky_user/features/location_service/domain/entity/address.dart';

import '../../../../fixtures/fixture_reader.dart';

main() {
  final tAddressModel = AddressModel(
    formattedAddress:
        'Aroor - Thoppumpady Rd, Valummel, Kochi, Kerala 682005, India',
    shortAddress: 'Aroor - Thoppumpady Rd',
    lat: 9.9311521,
    long: 76.2673925,
  );

  test('should be a subClass of Address', () {
    expect(tAddressModel, isA<Address>());
  });

  group('fromJson', () {
    test('should return a [AddressModel] from the given json', () async {
      final tJson = jsonDecode(await fixture('geo_coding_response.json'));

      final result = AddressModel.fromJson(tJson);
      expect(result, tAddressModel);
    });
  });
}
