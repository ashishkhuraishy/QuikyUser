import 'package:dartz/dartz.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/home/domain/entity/recipie.dart';
import 'package:quiky_user/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  @override
  Future<Either<Failure, List<Recipie>>> getRecipies() {
    // TODO: implement getRecipies
    throw UnimplementedError();
  }
}
