import 'package:dartz/dartz.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/location_service/data/model/address_model.dart';
import 'package:quiky_user/features/location_service/domain/entity/address.dart';

abstract class AddressRepository {
  Future<Either<Failure, Address>> getAddress();
  Future<Either<Failure, bool>> cacheAddress(Address address);
}
