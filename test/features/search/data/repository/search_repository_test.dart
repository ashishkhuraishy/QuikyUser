import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quiky_user/core/error/exception.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/home/domain/entity/offer.dart';
import 'package:quiky_user/features/home/domain/entity/restaurents.dart';
import 'package:quiky_user/features/search/data/data_source/search_local_data.dart';
import 'package:quiky_user/features/search/data/data_source/search_remote_data_source.dart';
import 'package:quiky_user/features/search/data/repository/search_repository_impl.dart';

import '../../../location_service/data/repository/address_repository_impl_test.dart';

class MockSearchLocalDataSource extends Mock implements SearchLocalDataSource {}

class MockSearchRemoteDataSource extends Mock
    implements SearchRemoteDataSource {}

main() {
  MockNetworkInfo mockNetworkInfo = MockNetworkInfo();
  MockSearchLocalDataSource localDataSource = MockSearchLocalDataSource();
  MockSearchRemoteDataSource remoteDataSource = MockSearchRemoteDataSource();

  SearchRepositoryImpl repositoryImpl = SearchRepositoryImpl(
    networkInfo: mockNetworkInfo,
    localDataSource: localDataSource,
    remoteDataSource: remoteDataSource,
  );

  final tRestaurent = Restaurant(
    id: 25,
    offers: [
      Offer(
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
    avgRating: '0',
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

  final tRestaurents = [tRestaurent];
  final tQuery = 'Test 1';
  final tLat = 9.5;
  final tLong = 5.5;

  final tList = ["t1", "t2", "t3"];

  setUp(() {
    when(mockNetworkInfo.isConnected)
        .thenAnswer((realInvocation) async => true);
    when(remoteDataSource.getResults(any, any, any))
        .thenAnswer((realInvocation) async => tRestaurents);
    when(localDataSource.getCache()).thenAnswer((realInvocation) => tList);
  });

  group('Get Result', () {
    test('should return [ConnectionFailure] if no internet connection',
        () async {
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => false);
      final result =
          await repositoryImpl.getResult(query: tQuery, lat: tLat, lng: tLong);
      expect(result, Left(ConnectionFailure()));
    });

    test('should return [Restaurents] if no exception occurs', () async {
      final result =
          await repositoryImpl.getResult(query: tQuery, lat: tLat, lng: tLong);
      verify(remoteDataSource.getResults(tQuery, tLat, tLong));
      // verify(localDataSource.newList(newList));
      expect(result, Right(tRestaurents));
    });

    test('should return [ServerFailure] exception occurs', () async {
      when(remoteDataSource.getResults(any, any, any))
          .thenThrow(ServerException());

      final result =
          await repositoryImpl.getResult(query: tQuery, lat: tLat, lng: tLong);
      verify(remoteDataSource.getResults(tQuery, tLat, tLong));
      expect(result, Right(ServerFailure()));
    });
  });
}
