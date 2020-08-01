import 'package:flutter/foundation.dart';
import 'package:quiky_user/features/user/domain/entity/user.dart';

class UserModel extends User {
  final int id;
  final int userId;
  final String userName;
  final String name;
  final String token;
  final String email;
  final String mobile;

  UserModel({
    @required this.id,
    @required this.userId,
    @required this.userName,
    @required this.name,
    @required this.token,
    @required this.email,
    @required this.mobile,
  }) : super(
          id: id,
          userId: userId,
          userName: userName,
          name: name,
          token: token,
          email: email,
          mobile: mobile,
        );
}
