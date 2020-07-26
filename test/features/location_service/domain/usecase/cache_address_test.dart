import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quiky_user/features/location_service/data/model/address_model.dart';
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
    lat: 9.9311521,
    long: 76.2673925,
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
