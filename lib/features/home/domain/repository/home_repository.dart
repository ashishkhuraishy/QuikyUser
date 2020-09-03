import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/home/data/data_source/home_remote_data_source.dart';
import 'package:quiky_user/features/home/domain/entity/recipie.dart';
import 'package:quiky_user/features/home/domain/entity/restaurents.dart';

abstract class HomeRepository {
  /// Return the List of Recipies near the User
  ///
  /// throws a [ServerFailure] if cannot retrive any data
  Future<Either<Failure, List<Recipie>>> getRecipies();

  Future<Either<Failure, List<Restaurant>>> getStores({
    @required double lat,
    @required double long,
    @required StoreType storeType,
  });
}
