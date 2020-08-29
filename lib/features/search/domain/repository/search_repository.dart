import 'package:dartz/dartz.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/home/domain/entity/restaurents.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<Restaurant>>> getResult(
      {String query, double lat, double lng});

  List<String> getQueries();
}
