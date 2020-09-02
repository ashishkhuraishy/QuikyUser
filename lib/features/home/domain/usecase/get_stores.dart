import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/home/data/data_source/home_remote_data_source.dart';
import 'package:quiky_user/features/home/domain/entity/restaurents.dart';
import 'package:quiky_user/features/home/domain/repository/home_repository.dart';

class GetStores {
  final HomeRepository repository;

  GetStores({this.repository});

  Future<Either<Failure, List<Restaurant>>> call({
    @required StoreType storeType,
    @required double lat,
    @required double lng,
  }) async {
    return await repository.getStores(
      lat: lat,
      long: lng,
      storeType: storeType,
    );
  }
}
