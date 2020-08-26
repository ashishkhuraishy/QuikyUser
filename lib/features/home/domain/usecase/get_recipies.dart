import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/home/domain/entity/recipie.dart';
import 'package:quiky_user/features/home/domain/repository/home_repository.dart';

class GetRecipies {
  final HomeRepository repository;

  GetRecipies({@required this.repository});

  Future<Either<Failure, List<Recipie>>> call() async {
    return await repository.getRecipies();
  }
}
