import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quiky_user/core/error/exception.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/home/data/data_source/home_remote_data_source.dart';
import 'package:quiky_user/features/home/data/model/offer_model.dart';
import 'package:quiky_user/features/home/data/model/recipie_model.dart';
import 'package:quiky_user/features/home/data/model/restaurant_model.dart';
import 'package:quiky_user/features/home/data/repository/home_repository_impl.dart';

import '../../../location_service/data/repository/address_repository_impl_test.dart';

class MockHomeRemoteDataSource extends Mock implements HomeRemoteDataSource {}

main() {
  MockHomeRemoteDataSource remoteDataSource;
  MockNetworkInfo networkInfo;
  HomeRepositoryImpl repositoryImpl;

  setUp(() {
    remoteDataSource = MockHomeRemoteDataSource();
    networkInfo = MockNetworkInfo();
    repositoryImpl = HomeRepositoryImpl(
      remoteDataSource: remoteDataSource,
      networkInfo: networkInfo,
    );
  });

  final recipieModel = RecipieModel(
    id: 1,
    title: 'test filter',
    imgUrl: 'http://3.7.65.63/media/1_BitcONx.jpg',
    stores: [1],
  );

  final recipies = [
    recipieModel,
    recipieModel,
    recipieModel,
  ];

  final restaurentModel = RestaurantModel(
    id: 25,
    offers: [
      OfferModel(
        id: 1,
        title: 'Quicky50',
        code: 'quick',
        text: '',
        offerId: 3,
        percentage: '40',
      ),
    ],
    employeeId: "97632",
    title: "MRA Bakery And Restaurant",
    mobile: "85930 12345",
    gst: '',
    tinTan: '',
    typeGoods: "food",
    delivery: false,
    vendor: true,
    customer: false,
    popularBrand: true,
    brandLogo: "/media/images.png",
    profilePicture: "/media/8.png",
    fssai: "11319007002211",
    storeSubType: "Indian, Chinese",
    status: "opened",
    option: "trending",
    totalReviews: "0",
    avgRating: '',
    coordinate: "10.0142468,76.2775775",
    address:
        "ARRA-96 Cheranalllur Road Bypass Junction, Ponekkara, Edappally, Opposite lulu mall, Kochi, Kerala 682024",
    recommendationCount: '',
    minimumCostTwo: '450',
    avgDeliveryTime: "4.5",
    active: true,
    inOrder: false,
    bulkOrder: false,
    opening: '',
    closing: '',
    highlightStatus: true,
    featuredBrand: true,
    commisionPercentage: '',
    user: "37",
    city: "1",
    zone: '',
    vendorLocation: "10.0142468,76.2775775",
  );

  final restaurants = [
    restaurentModel,
    restaurentModel,
    restaurentModel,
  ];

  final tStoreType = StoreType.inTheSpotlight;

  final lat = 0.0, long = 0.0;

  group('Get Recipies', () {
    setUp(() {
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
    });

    test('should check the network status', () async {
      await repositoryImpl.getRecipies();
      verify(networkInfo.isConnected);
    });

    test('should return Connection failure if not connected', () async {
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);

      final result = await repositoryImpl.getRecipies();
      verify(networkInfo.isConnected);
      verifyZeroInteractions(remoteDataSource);
      expect(result, Left(ConnectionFailure()));
    });

    test('should get the recipies from the remote source', () async {
      await repositoryImpl.getRecipies();
      verify(remoteDataSource.getRecipies());
    });

    test('should return [List<Recipie>] on sucess', () async {
      when(remoteDataSource.getRecipies())
          .thenAnswer((realInvocation) async => recipies);

      final result = await repositoryImpl.getRecipies();
      verify(remoteDataSource.getRecipies());

      expect(result, Right(recipies));
    });

    test('should return [ServerFailure] on ServerException', () async {
      when(remoteDataSource.getRecipies()).thenThrow(ServerException());

      final result = await repositoryImpl.getRecipies();
      verify(remoteDataSource.getRecipies());

      expect(result, Left(ServerFailure()));
    });
  });
  group('get Stores', () {
    setUp(() {
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
    });

    test('should check the network status', () async {
      await repositoryImpl.getStores(
          lat: lat, long: long, storeType: tStoreType);
      verify(networkInfo.isConnected);
    });

    test('should return Connection failure if not connected', () async {
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);

      final result = await repositoryImpl.getStores(
          lat: lat, long: long, storeType: tStoreType);
      verify(networkInfo.isConnected);
      verifyZeroInteractions(remoteDataSource);
      expect(result, Left(ConnectionFailure()));
    });

    test('should get the restaurents from the remote source', () async {
      await repositoryImpl.getStores(
          lat: lat, long: long, storeType: tStoreType);
      verify(remoteDataSource.getStores(
        lat: lat,
        long: long,
        storeType: tStoreType,
      ));
    });

    test('should return [List<restaurent>] on sucess', () async {
      when(
        remoteDataSource.getStores(
          lat: anyNamed('lat'),
          long: anyNamed('long'),
          storeType: anyNamed('storeType'),
        ),
      ).thenAnswer((realInvocation) async => restaurants);

      final result = await repositoryImpl.getStores(
        lat: lat,
        long: long,
        storeType: tStoreType,
      );
      verify(remoteDataSource.getStores(
          lat: lat, long: long, storeType: tStoreType));

      expect(result, Right(restaurants));
    });

    test('should return [ServerFailure] on ServerException', () async {
      when(remoteDataSource.getStores(
              lat: anyNamed('lat'),
              long: anyNamed('long'),
              storeType: anyNamed('storeType')))
          .thenThrow(ServerException());

      final result = await repositoryImpl.getStores(
          lat: lat, long: long, storeType: tStoreType);
      verify(remoteDataSource.getStores(
          lat: lat, long: long, storeType: tStoreType));

      expect(result, Left(ServerFailure()));
    });
  });
}
