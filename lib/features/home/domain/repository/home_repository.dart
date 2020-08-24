import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/home/domain/entity/recipie.dart';
import 'package:quiky_user/features/home/domain/entity/restaurents.dart';

abstract class HomeRepository {
  /// Return the List of Recipies near the User
  ///
  /// throws a [ServerFailure] if cannot retrive any data
  Future<Either<Failure, List<Recipie>>> getRecipies();
  Future<Either<Failure, List<Restaurant>>> getFeatured({
    @required double lat,
    @required double long,
  });
  Future<Either<Failure, List<Restaurant>>> getPopular({
    @required double lat,
    @required double long,
  });
  Future<Either<Failure, List<Restaurant>>> getTrendingRestaurents({
    @required double lat,
    @required double long,
  });
  Future<Either<Failure, List<Restaurant>>> getTrendingGrocery({
    @required double lat,
    @required double long,
  });
}
