import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quiky_user/core/error/exception.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/home/data/data_source/home_remote_data_source.dart';
import 'package:quiky_user/features/home/data/model/recipie_model.dart';
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
}
