import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/location_service/domain/entity/address.dart';
import 'package:quiky_user/features/location_service/domain/repository/address_repo.dart';

class CacheAddress {
  final AddressRepository repo;

  CacheAddress({@required this.repo});

  Future<Either<Failure, bool>> call(Address address) async {
    return await repo.cacheAddress(address);
  }
}
