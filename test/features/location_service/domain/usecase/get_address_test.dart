import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quiky_user/features/location_service/domain/entity/address.dart';
import 'package:quiky_user/features/location_service/domain/repository/address_repo.dart';
import 'package:quiky_user/features/location_service/domain/usecase/get_address.dart';

class MockAddressRepo extends Mock implements AddressRepository {}

void main() {
  GetAddress getAddress;
  MockAddressRepo mockAddressRepo;

  setUp(() {
    mockAddressRepo = MockAddressRepo();
    getAddress = GetAddress(mockAddressRepo);
  });

  final tAddress = Address(
    formattedAddress: '',
    shortAddress: '',
    lat: 9.9311521,
    long: 76.2673925,
  );

  test('should return a Address obj when called', () async {
    when(mockAddressRepo.getAddress())
        .thenAnswer((realInvocation) async => Right(tAddress));

    final result = await getAddress.execute();
    verify(mockAddressRepo.getAddress());
    expect(result, Right(tAddress));
    verifyNoMoreInteractions(mockAddressRepo);
  });
}
