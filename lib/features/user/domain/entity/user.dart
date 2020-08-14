import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class User extends Equatable {
  final int id;
  final int userId;
  final String userName;
  final String name;
  final String token;
  final String email;
  final String mobile;

  User({
    @required this.id,
    @required this.userId,
    @required this.userName,
    @required this.name,
    @required this.token,
    @required this.email,
    @required this.mobile,
  });

  @override
  List<Object> get props => [
        id,
        userId,
        userName,
        name,
        token,
        email,
        mobile,
      ];
}
