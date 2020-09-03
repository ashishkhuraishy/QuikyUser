import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:quiky_user/core/error/exception.dart';
import 'package:quiky_user/features/home/data/data_source/home_remote_data_source.dart';
import 'package:quiky_user/features/home/data/model/recipie_model.dart';
import 'package:quiky_user/features/home/domain/entity/restaurents.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../location_service/data/data_source/address_remote_data_source_test.dart';

main() {
  MockHttpClient mockClient;
  HomeRemoteDataSourceImpl dataSourceImpl;

  setUp(() {
    mockClient = MockHttpClient();
    dataSourceImpl = HomeRemoteDataSourceImpl(
      client: mockClient,
    );
  });

  final recipies = [
    RecipieModel(
      id: 1,
      title: "test filter",
      imgUrl: "http://3.7.65.63/media/1_BitcONx.jpg",
      stores: [1, 5],
    ),
    RecipieModel(
      id: 2,
      title: "test filter",
      imgUrl: "http://3.7.65.63/media/1_BitcONx.jpg",
      stores: [1, 9],
    ),
  ];

  final lat = 0.0, long = 0.0;

  group('Get Recipies', () {
    final url = 'http://3.7.65.63/api/recipe/';

    setUp(() {
      when(mockClient.get(any)).thenAnswer(
        (realInvocation) async => Response(fixture('recipies_mock.json'), 200),
      );
    });

    test('should perform a get() on the url', () {
      dataSourceImpl.getRecipies();
      verify(mockClient.get(any));
    });

    test('should return List<RecipieModel> when status 200', () async {
      final result = await dataSourceImpl.getRecipies();
      verify(mockClient.get(url));

      expect(result, recipies);
    });

    test('should throw ServerException when status not 200', () async {
      when(mockClient.get(any)).thenAnswer(
        (realInvocation) async => Response(fixture('recipies_mock.json'), 404),
      );

      final result = dataSourceImpl.getRecipies;
      expect(() => result(), throwsA(isA<ServerException>()));
      verify(mockClient.get(url));
    });
  });

  group('Get Stores', () {
    final url = BASE_URL + '/store_list/';

    setUp(() {
      when(mockClient.get(any)).thenAnswer(
        (realInvocation) async => Response(fixture('brands.json'), 200),
      );
    });

    test('should perform a get() on the url', () {
      dataSourceImpl.getStores(
        lat: lat,
        long: long,
        storeType: StoreType.trendingGroceries,
      );
      verify(mockClient.get(any));
    });

    test('should return List<RestaurentModel> when status 200', () async {
      final result = await dataSourceImpl.getStores(
        lat: lat,
        long: long,
        storeType: StoreType.trendingGroceries,
      );
      verify(mockClient
          .get(url + '?lat=$lat&lon=$long&filter=trending&store_type=grocery'));

      expect(result, isA<List<Restaurant>>());
    });

    test('should throw ServerException when status not 200', () async {
      when(mockClient.get(any)).thenAnswer(
        (realInvocation) async => Response(fixture('brands.json'), 404),
      );

      final result = dataSourceImpl.getStores;
      expect(
          () => result(
                lat: lat,
                long: long,
                storeType: StoreType.trendingGroceries,
              ),
          throwsA(isA<ServerException>()));
      verify(mockClient.get(
        url + '?lat=$lat&lon=$long&filter=trending&store_type=grocery',
      ));
    });
  });
}
