import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/platform/location_info.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entity/address.dart';
import '../../domain/repository/address_repo.dart';
import '../data_source/address_local_data_sourc.dart';
import '../data_source/address_remote_data_source.dart';

class AddressRepositoryImpl extends AddressRepository {
  final NetworkInfo networkInfo;
  final LocationInfo locationInfo;
  final AddressRemoteDataSource remoteDataSource;
  final AddressLocalDataSource localDataSource;

  AddressRepositoryImpl({
    this.networkInfo,
    this.locationInfo,
    this.remoteDataSource,
    this.localDataSource,
  });

  @override
  Future<Either<Failure, Address>> getAddress() async {
    bool hasPermission = await locationInfo.locationPermission;
    bool isConnected = await networkInfo.isConnected;

    if (!isConnected || !hasPermission) {
      try {
        return Right(await localDataSource.getAnyAddress());
      } on CacheException {
        if (!isConnected) return Left(ConnectionFailure());
        if (!hasPermission) return Left(LocationFailure());
      }
    }

    final currentLocation = await locationInfo.currentLocation;
    try {
      final result = await remoteDataSource.getAddress(currentLocation);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> cacheAddress(Address address) async {
    final response = await localDataSource.cacheAddress(address);
    if (response) {
      return Right(true);
    }
    return Left(CacheFailure());
  }
}
