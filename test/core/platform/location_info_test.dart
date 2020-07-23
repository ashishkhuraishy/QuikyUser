import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mockito/mockito.dart';
import 'package:quiky_user/core/platform/location_info.dart';

class MockLocation extends Mock implements Location {}

class MockLocationData extends Mock implements LocationData {}

main() {
  MockLocation mockLocation;
  MockLocationData mockLocationData;
  LocationInfoImpl locationInfoImpl;

  setUp(() {
    mockLocation = MockLocation();
    locationInfoImpl = LocationInfoImpl(location: mockLocation);

    mockLocationData = MockLocationData();
  });

  group('Check Permission', () {
    setUp(() {
      when(mockLocation.hasPermission()).thenAnswer(
        (realInvocation) async => PermissionStatus.granted,
      );
      when(mockLocation.serviceEnabled()).thenAnswer(
        (realInvocation) async => true,
      );
    });

    test('should run hasPermission and serviceEnabled', () async {
      when(mockLocation.hasPermission()).thenAnswer(
        (realInvocation) async => PermissionStatus.granted,
      );
      when(mockLocation.serviceEnabled()).thenAnswer(
        (realInvocation) async => true,
      );
      await locationInfoImpl.locationPermission;
      verify(mockLocation.hasPermission());
      verify(mockLocation.serviceEnabled());
    });

    test('should return true when permmsion granted and service enabled',
        () async {
      when(mockLocation.hasPermission()).thenAnswer(
        (realInvocation) async => PermissionStatus.granted,
      );
      when(mockLocation.serviceEnabled()).thenAnswer(
        (realInvocation) async => true,
      );

      final result = await locationInfoImpl.locationPermission;
      verify(mockLocation.hasPermission());
      verify(mockLocation.serviceEnabled());
      expect(result, true);
    });

    test('should return false if permmsion denied or service disabled',
        () async {
      when(mockLocation.hasPermission()).thenAnswer(
        (realInvocation) async => PermissionStatus.denied,
      );
      when(mockLocation.serviceEnabled()).thenAnswer(
        (realInvocation) async => false,
      );

      when(mockLocation.requestPermission()).thenAnswer(
        (realInvocation) async => PermissionStatus.deniedForever,
      );
      when(mockLocation.requestService()).thenAnswer(
        (realInvocation) async => false,
      );

      final result = await locationInfoImpl.locationPermission;
      verify(mockLocation.hasPermission());
      verify(mockLocation.serviceEnabled());
      verify(mockLocation.requestPermission());
      verify(mockLocation.requestService());
      expect(result, false);
    });

    test('should request to enable service if disabled', () async {
      when(mockLocation.serviceEnabled()).thenAnswer(
        (realInvocation) async => false,
      );
      when(mockLocation.requestService()).thenAnswer(
        (realInvocation) async => true,
      );

      await locationInfoImpl.locationPermission;
      verify(mockLocation.requestService());
    });

    test('should request to enable location if disabled', () async {
      when(mockLocation.hasPermission()).thenAnswer(
        (realInvocation) async => PermissionStatus.denied,
      );

      when(mockLocation.requestPermission()).thenAnswer(
        (realInvocation) async => PermissionStatus.granted,
      );

      await locationInfoImpl.locationPermission;
      verify(mockLocation.requestPermission());
    });
  });

  group('Get Currrent Location', () {
    setUp(() {
      when(mockLocation.getLocation())
          .thenAnswer((realInvocation) async => mockLocationData);
      when(mockLocationData.latitude).thenAnswer((realInvocation) => 0.0);
      when(mockLocationData.longitude).thenAnswer((realInvocation) => 0.0);
    });

    test('should forward to Location.getLocation', () async {
      await locationInfoImpl.currentLocation;
      verify(mockLocation.getLocation());
    });

    test('should return a LatLng with LocationData Info', () async {
      final result = await locationInfoImpl.currentLocation;
      verify(mockLocation.getLocation());
      expect(result, isA<LatLng>());
      expect(result,
          LatLng(mockLocationData.latitude, mockLocationData.longitude));
    });
  });
}
