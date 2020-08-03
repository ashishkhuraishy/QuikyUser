import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/user/domain/entity/user.dart';
import 'package:quiky_user/features/user/domain/repository/user_repository.dart';

class Login {
  final UserRepository repository;

  Login(this.repository);

  Future<Either<Failure, User>> call({
    @required String username,
    @required String password,
  }) async {
    return await repository.login(username: username, password: password);
  }
}
