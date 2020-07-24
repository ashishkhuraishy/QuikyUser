import 'package:dartz/dartz.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/home/domain/entity/recipie.dart';

abstract class HomeRepository {
  /// Return the List of Recipies near the User
  ///
  /// throws a [ServerFailure] if cannot retrive any data
  Future<Either<Failure, List<Recipie>>> getRecipies();
}
