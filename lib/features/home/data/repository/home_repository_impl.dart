import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiky_user/core/error/exception.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/core/platform/network_info.dart';
import 'package:quiky_user/features/home/data/data_source/home_remote_data_source.dart';
import 'package:quiky_user/features/home/domain/entity/recipie.dart';
import 'package:quiky_user/features/home/domain/entity/restaurents.dart';
import 'package:quiky_user/features/home/domain/repository/home_repository.dart';

typedef Future<List<Restaurant>> _GetRestaurantsOrError();

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl({
    @required this.networkInfo,
    @required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Recipie>>> getRecipies() async {
    if (!await networkInfo.isConnected) return Left(ConnectionFailure());

    try {
      final result = await remoteDataSource.getRecipies();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Restaurant>>> getFeatured(
      {double lat, double long}) async {
    return await _getRestaurants(
      () => remoteDataSource.getFeatured(
        lat: lat,
        long: long,
      ),
    );
  }

  @override
  Future<Either<Failure, List<Restaurant>>> getPopular(
      {double lat, double long}) async {
    return await _getRestaurants(
      () => remoteDataSource.getPopular(
        lat: lat,
        long: long,
      ),
    );
  }

  @override
  Future<Either<Failure, List<Restaurant>>> getTrendingGrocery(
      {double lat, double long}) async {
    return await _getRestaurants(
      () => remoteDataSource.getTrendingGrocery(
        lat: lat,
        long: long,
      ),
    );
  }

  @override
  Future<Either<Failure, List<Restaurant>>> getTrendingRestaurents(
      {double lat, double long}) async {
    return await _getRestaurants(
      () => remoteDataSource.getTrendingRestaurents(
        lat: lat,
        long: long,
      ),
    );
  }

  Future<Either<Failure, List<Restaurant>>> _getRestaurants(
      _GetRestaurantsOrError _getRestaurantsOrError) async {
    if (!await networkInfo.isConnected) return Left(ConnectionFailure());

    try {
      final result = await _getRestaurantsOrError();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
