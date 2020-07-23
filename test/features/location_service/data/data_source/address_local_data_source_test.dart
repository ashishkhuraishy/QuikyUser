import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:quiky_user/core/error/exception.dart';
import 'package:quiky_user/features/location_service/data/data_source/address_local_data_sourc.dart';
import 'package:quiky_user/features/location_service/data/model/address_model.dart';

class MockHive extends Mock implements HiveInterface {}

class MockHiveBox extends Mock implements Box {}

main() {
  MockHive mockHive;
  MockHiveBox mockHiveBox;
  AddresLocalDataSourceImpl localDataSourceImpl;

  final tAddressModel = AddressModel(
    formattedAddress:
        'Aroor - Thoppumpady Rd, Valummel, Kochi, Kerala 682005, India',
    shortAddress: 'Aroor - Thoppumpady Rd',
    lat: 9.9311521,
    long: 76.2673925,
  );

  setUp(() {
    mockHive = MockHive();
    mockHiveBox = MockHiveBox();
    localDataSourceImpl = AddresLocalDataSourceImpl(hive: mockHive);
  });

  group('cache Address', () {
    setUp(() {
      when(mockHive.isBoxOpen(any)).thenAnswer((realInvocation) => true);
    });

    test('Check if the AddressBox is open', () {
      localDataSourceImpl.cacheAddress(tAddressModel);
      verify(mockHive.isBoxOpen(ADDRESS_BOX));
    });

    test('should open the AddressBox box if closed', () {
      when(mockHive.isBoxOpen(any)).thenAnswer((realInvocation) => false);
      localDataSourceImpl.cacheAddress(tAddressModel);
      verify(mockHive.isBoxOpen(ADDRESS_BOX));
      verify(mockHive.openBox(ADDRESS_BOX));
    });

    test('should put the AddressModel data on the box', () async {
      when(mockHive.box(any)).thenReturn(mockHiveBox);
      when(mockHiveBox.add(any)).thenAnswer((realInvocation) async => 1);

      final result = await localDataSourceImpl.cacheAddress(tAddressModel);
      verify(mockHive.box(ADDRESS_BOX));
      verify(mockHiveBox.add(tAddressModel));

      expect(result, true);
    });
  });

  group('get Any address', () {
    setUp(() {
      when(mockHive.isBoxOpen(any)).thenAnswer((realInvocation) => true);
      when(mockHive.box(any)).thenReturn(mockHiveBox);
      when(mockHiveBox.isNotEmpty).thenAnswer((realInvocation) => true);
      when(mockHiveBox.getAt(any))
          .thenAnswer((realInvocation) => tAddressModel);
    });

    test('check if the box is open', () async {
      await localDataSourceImpl.getAnyAddress();
      verify(mockHive.isBoxOpen(ADDRESS_BOX));
    });

    test('should open the AddressBox box if closed', () {
      when(mockHive.isBoxOpen(any)).thenAnswer((realInvocation) => false);
      localDataSourceImpl.getAnyAddress();
      verify(mockHive.isBoxOpen(ADDRESS_BOX));
      verify(mockHive.openBox(ADDRESS_BOX));
    });

    test('should check the box is empty', () {
      localDataSourceImpl.getAnyAddress();
      verify(mockHiveBox.isNotEmpty);
    });

    test('should return first [AddressModel] if the box is not empty',
        () async {
      final result = await localDataSourceImpl.getAnyAddress();
      verify(mockHiveBox.isNotEmpty);
      verify(mockHiveBox.getAt(0));

      expect(result, tAddressModel);
    });

    test('should throw [CacheException] if the box is empty', () async {
      when(mockHiveBox.isNotEmpty).thenAnswer((realInvocation) => false);

      final result = localDataSourceImpl.getAnyAddress;
      expect(() => result(), throwsA(isA<CacheException>()));
    });
  });
}
