import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:quiky_user/Constants/Apikeys.dart';
import 'package:quiky_user/core/error/exception.dart';
import 'package:quiky_user/features/location_service/data/data_source/address_remote_data_source.dart';
import 'package:quiky_user/features/location_service/data/model/address_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements Client {}

main() {
  MockHttpClient mockHttpClient;
  AddressRemoteDataSourceImpl remoteDataSourceImpl;
  setUp(() {
    mockHttpClient = MockHttpClient();
    remoteDataSourceImpl = AddressRemoteDataSourceImpl(client: mockHttpClient);
  });

  final tLocation = LatLng(0, 0);
  final tAddressModel = AddressModel(
    formattedAddress:
        'Aroor - Thoppumpady Rd, Valummel, Kochi, Kerala 682005, India',
    shortAddress: 'Aroor - Thoppumpady Rd',
    lat: 9.9311521,
    long: 76.2673925,
  );

  test('should perform a get request on gMap api', () {
    when(mockHttpClient.get(any)).thenAnswer(
      (realInvocation) async =>
          Response(await fixture('geo_coding_response.json'), 200),
    );
    remoteDataSourceImpl.getAddress(tLocation);
    verify(
      mockHttpClient
          .get(GMapURL + '${tLocation.latitude},${tLocation.longitude}'),
    );
  });
  test('should return AddressModel if statusCode 200', () async {
    when(mockHttpClient.get(any)).thenAnswer(
      (realInvocation) async =>
          Response(await fixture('geo_coding_response.json'), 200),
    );

    final result = await remoteDataSourceImpl.getAddress(tLocation);
    verify(
      mockHttpClient
          .get(GMapURL + '${tLocation.latitude},${tLocation.longitude}'),
    );
    expect(result, tAddressModel);
  });

  test('should throw Serverexception if statusCode is not 200', () async {
    when(mockHttpClient.get(any)).thenAnswer(
      (realInvocation) async =>
          Response(await fixture('geo_coding_response.json'), 404),
    );

    final call = remoteDataSourceImpl.getAddress;
    expect(() => call(tLocation), throwsA(isA<ServerException>()));
  });
}
