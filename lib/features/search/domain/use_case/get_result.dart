import 'package:dartz/dartz.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/home/domain/entity/restaurents.dart';
import 'package:quiky_user/features/search/domain/repository/search_repository.dart';

class GetResults {
  final SearchRepository repository;

  GetResults({this.repository});

  Future<Either<Failure, List<Restaurant>>> call(
      {String query, double lat, double long}) async {
    return await repository.getResult(query: query, lat: lat, lng: long);
  }
}
