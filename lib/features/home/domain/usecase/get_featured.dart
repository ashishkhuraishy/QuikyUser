import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/home/domain/entity/restaurents.dart';
import 'package:quiky_user/features/home/domain/repository/home_repository.dart';

class GetFeatured {
  final HomeRepository repository;

  GetFeatured({@required this.repository});

  Future<Either<Failure, List<Restaurant>>> call({
    @required double lat,
    @required double long,
  }) async {
    return await repository.getFeatured(lat: lat, long: long);
  }
}
