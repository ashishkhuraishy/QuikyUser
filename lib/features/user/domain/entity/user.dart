import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final int userId;
  final String userName;
  final String name;
  final String token;
  final String email;
  final String mobile;

  User({
    this.id,
    this.userId,
    this.userName,
    this.name,
    this.token,
    this.email,
    this.mobile,
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
