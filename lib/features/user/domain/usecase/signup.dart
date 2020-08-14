import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/user/domain/entity/user.dart';
import 'package:quiky_user/features/user/domain/repository/user_repository.dart';

class SignUp {
  final UserRepository repository;

  SignUp(this.repository);

  Future<Either<Failure, User>> call({
    @required String username,
    @required String password,
    @required String name,
  }) async {
    return await repository.signUp(
      username: username,
      name: name,
      password: password,
    );
  }
}
