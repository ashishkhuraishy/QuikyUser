import 'package:flutter/cupertino.dart';
import 'package:quiky_user/features/user/data/model/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> login({
    @required String username,
    @required String password,
  });

  Future<UserModel> signUp({
    @required String username,
    @required String name,
    @required String email,
    @required String phoneNo,
    @required String password,
  });
}
