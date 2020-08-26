import 'package:flutter/cupertino.dart';
import 'package:quiky_user/core/platform/network_info.dart';
import 'package:quiky_user/features/user/data/datasource/user_local_data_source.dart';
import 'package:quiky_user/features/user/data/datasource/user_remote_data_source.dart';
import 'package:quiky_user/features/user/domain/entity/user.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:quiky_user/features/user/domain/repository/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final NetworkInfo networkInfo;
  final UserLocalDataSource localDataSource;
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({
    @required this.networkInfo,
    @required this.localDataSource,
    @required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, User>> login({
    String username,
    String password,
  }) async {
    if (!await networkInfo.isConnected) return Left(ConnectionFailure());

    try {
      final user =
          await remoteDataSource.login(username: username, password: password);
      await localDataSource.cacheUser(user);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  void logout() {
    localDataSource.logout();
  }

  @override
  Future<Either<Failure, User>> signUp({
    String username,
    String name,
    String password,
  }) async {
    if (!await networkInfo.isConnected) return Left(ConnectionFailure());

    try {
      final user = await remoteDataSource.signUp(
        username: username,
        password: password,
        name: name,
      );
      await localDataSource.cacheUser(user);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
