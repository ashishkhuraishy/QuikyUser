import 'package:dartz/dartz.dart';
import 'package:quiky_user/core/error/exception.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/core/platform/location_info.dart';
import 'package:quiky_user/core/platform/network_info.dart';
import 'package:quiky_user/features/location_service/data/data_source/address_local_data_sourc.dart';
import 'package:quiky_user/features/location_service/data/data_source/address_remote_data_source.dart';
import 'package:quiky_user/features/location_service/data/model/address_model.dart';
import 'package:quiky_user/features/location_service/domain/entity/address.dart';
import 'package:quiky_user/features/location_service/domain/repository/address_repo.dart';

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
    if (!isConnected) return Left(ConnectionFailure());
    if (!hasPermission) return Left(LocationFailure());

    final currentLocation = await locationInfo.currentLocation;
    try {
      final result = await remoteDataSource.getAddress(currentLocation);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> cacheAddress(AddressModel address) {
    // TODO: implement cacheAddress
    throw UnimplementedError();
  }
}
