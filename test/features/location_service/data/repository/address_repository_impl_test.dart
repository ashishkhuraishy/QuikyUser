import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:quiky_user/core/error/exception.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/core/platform/location_info.dart';
import 'package:quiky_user/core/platform/network_info.dart';
import 'package:quiky_user/features/location_service/data/data_source/address_local_data_sourc.dart';
import 'package:quiky_user/features/location_service/data/data_source/address_remote_data_source.dart';
import 'package:quiky_user/features/location_service/data/model/address_model.dart';
import 'package:quiky_user/features/location_service/data/repository/address_repository_imp.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockLocationInfo extends Mock implements LocationInfo {}

class MockAddressRemoteDataSource extends Mock
    implements AddressRemoteDataSource {}

class MockAddressLocalDataSource extends Mock
    implements AddressLocalDataSource {}

main() async {
  MockNetworkInfo mockNetworkInfo;
  MockLocationInfo mockLocationInfo;
  MockAddressRemoteDataSource mockRemoteDataSource;
  MockAddressLocalDataSource mockLocalDataSource;

  AddressRepositoryImpl repositoryImpl;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockLocationInfo = MockLocationInfo();
    mockRemoteDataSource = MockAddressRemoteDataSource();
    mockLocalDataSource = MockAddressLocalDataSource();

    repositoryImpl = AddressRepositoryImpl(
      networkInfo: mockNetworkInfo,
      locationInfo: mockLocationInfo,
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tLocation = LatLng(0, 0);
  final tAddressModel = AddressModel(
    formattedAddress:
        'Aroor - Thoppumpady Rd, Valummel, Kochi, Kerala 682005, India',
    shortAddress: 'Aroor - Thoppumpady Rd',
    latLng: LatLng(
      9.9311521,
      76.2673925,
    ),
  );

  group('getAddress', () {
    group('getAddress isOnline and hasPermission', () {
      setUp(() {
        when(mockLocationInfo.currentLocation)
            .thenAnswer((realInvocation) async => tLocation);
        when(mockLocationInfo.locationPermission)
            .thenAnswer((realInvocation) async => true);
        when(mockNetworkInfo.isConnected)
            .thenAnswer((realInvocation) async => true);
      });

      test('should get the current location', () async {
        await repositoryImpl.getAddress();
        verify(mockLocationInfo.currentLocation);
      });

      test('should get the network status of the device', () async {
        await repositoryImpl.getAddress();
        verify(mockNetworkInfo.isConnected);
      });

      test('should get the location permission status', () async {
        await repositoryImpl.getAddress();
        verify(mockLocationInfo.locationPermission);
      });

      test(
          'should return AddressModel from RemoteDataSource with a LatLang input if sucessfull',
          () async {
        when(mockRemoteDataSource.getAddress(any))
            .thenAnswer((realInvocation) async => tAddressModel);

        final result = await repositoryImpl.getAddress();
        verify(mockLocationInfo.currentLocation);
        verify(mockRemoteDataSource.getAddress(any));

        expect(result, Right(tAddressModel));
      });

      test('should return [ServerFailure] if remote call unsucessful',
          () async {
        when(mockRemoteDataSource.getAddress(any)).thenThrow(ServerException());

        final result = await repositoryImpl.getAddress();
        verify(mockLocationInfo.currentLocation);
        verify(mockRemoteDataSource.getAddress(any));

        expect(result, Left(ServerFailure()));
      });
    });

    test('return Network Failure if no Internet Connection available',
        () async {
      when(mockLocationInfo.locationPermission)
          .thenAnswer((realInvocation) async => true);
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => false);

      final result = await repositoryImpl.getAddress();
      verifyZeroInteractions(mockRemoteDataSource);
      expect(result, Left(ConnectionFailure()));
    });

    test('return Location Failure if LocationPermission denied', () async {
      when(mockLocationInfo.locationPermission)
          .thenAnswer((realInvocation) async => false);
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true);

      final result = await repositoryImpl.getAddress();
      verifyZeroInteractions(mockRemoteDataSource);
      expect(result, Left(LocationFailure()));
    });
  });
}
