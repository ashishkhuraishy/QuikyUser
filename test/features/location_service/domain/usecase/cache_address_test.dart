import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:quiky_user/features/location_service/data/model/address_model.dart';
import 'package:quiky_user/features/location_service/domain/entity/address.dart';
import 'package:quiky_user/features/location_service/domain/repository/address_repo.dart';
import 'package:quiky_user/features/location_service/domain/usecase/cache_address.dart';

class MockAddressRepo extends Mock implements AddressRepository {}

main() {
  MockAddressRepo addressRepo;
  CacheAddress cacheAddress;

  setUp(() {
    addressRepo = MockAddressRepo();
    cacheAddress = CacheAddress(repo: addressRepo);
  });

  final tAddress = AddressModel(
    formattedAddress: '',
    shortAddress: '',
    latLng: LatLng(0.0, 0.0),
  );

  test('should return a Address obj when called', () async {
    when(addressRepo.cacheAddress(any))
        .thenAnswer((realInvocation) async => Right(true));

    final result = await cacheAddress(tAddress);
    verify(addressRepo.cacheAddress(tAddress));
    expect(result, Right(true));
    verifyNoMoreInteractions(addressRepo);
  });
}
