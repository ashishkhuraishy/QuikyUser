import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:quiky_user/features/user/domain/entity/user.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel extends User {
  @HiveField(4)
  final int id;
  @HiveField(5)
  final int userId;
  @HiveField(6)
  final String userName;
  @HiveField(7)
  final String name;
  @HiveField(8)
  final String token;
  @HiveField(9)
  final String email;
  @HiveField(10)
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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['profile']['id'],
      userId: json['profile']['userdetails']['id'],
      userName: json['profile']['username'],
      name: json['profile']['first_name'],
      token: json['token'],
      email: json['profile']['email'],
      mobile: json['profile']['userdetails']['mobile'],
    );
  }
}
