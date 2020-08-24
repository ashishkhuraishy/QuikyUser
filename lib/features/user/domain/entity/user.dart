import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 11)
class User extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int userId;
  @HiveField(2)
  final String userName;
  @HiveField(3)
  final String name;
  @HiveField(4)
  final String token;
  @HiveField(5)
  final String email;
  @HiveField(6)
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
