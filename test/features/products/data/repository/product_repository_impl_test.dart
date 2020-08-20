import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quiky_user/core/error/exception.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/products/data/data_source/product_remote_data_source.dart';
import 'package:quiky_user/features/products/data/models/category_model.dart';
import 'package:quiky_user/features/products/data/models/store_product_models.dart';
import 'package:quiky_user/features/products/data/repository/product_repository_impl.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../location_service/data/repository/address_repository_impl_test.dart';

class MockProductRemoteDataSource extends Mock
    implements ProductsRemoteDataSource {}

main() {
  MockProductRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  ProductRepositoryImpl repositoryImpl;

  setUp(() {
    mockRemoteDataSource = MockProductRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = ProductRepositoryImpl(
      networkInfo: mockNetworkInfo,
      remoteDataSource: mockRemoteDataSource,
    );
  });

  final tStoreId = 1;
  final tCategories = jsonDecode(fixture('categories.json'))
      .map<CategoryModel>((e) => CategoryModel.fromJson(e))
      .toList();

  final tProducts = StoreProductsModel.fromJson(
    jsonDecode(
      fixture('store-products.json'),
    ),
  );

  // print(tCategories.length);
  // print(tProducts.products.length);

  group('Get Products', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer(
        (realInvocation) async => true,
      );
      when(mockRemoteDataSource.getCategories(any)).thenAnswer(
        (realInvocation) async => tCategories,
      );
      when(mockRemoteDataSource.getProducts(any)).thenAnswer(
        (realInvocation) async => tProducts,
      );
    });

    test('check Internet connection', () {
      repositoryImpl.getProducts(tStoreId);
      verify(mockNetworkInfo.isConnected);
    });

    test('should return [ConnectionFailure] if there is no internet connection',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer(
        (realInvocation) async => false,
      );

      final result = await repositoryImpl.getProducts(tStoreId);

      verify(mockNetworkInfo.isConnected);
      expect(result, Left(ConnectionFailure()));
    });

    test('should return list of categories', () async {
      final result = await repositoryImpl.getProducts(tStoreId);
      verify(mockRemoteDataSource.getCategories(tStoreId));
      verify(mockRemoteDataSource.getProducts(tStoreId));

      expect(result, Right(tCategories));
    });

    test('should return [ServerFailure] if categories return error', () async {
      when(mockRemoteDataSource.getCategories(any))
          .thenThrow(ServerException());
      final result = await repositoryImpl.getProducts(tStoreId);
      verify(mockRemoteDataSource.getCategories(tStoreId));

      expect(result, Left(ServerFailure()));
    });

    test('should return [ServerFailure] if products return error', () async {
      when(mockRemoteDataSource.getProducts(any)).thenThrow(ServerException());
      final result = await repositoryImpl.getProducts(tStoreId);
      verify(mockRemoteDataSource.getCategories(tStoreId));
      verify(mockRemoteDataSource.getProducts(tStoreId));

      expect(result, Left(ServerFailure()));
    });
  });
}
