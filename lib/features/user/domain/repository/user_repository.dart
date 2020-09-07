import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/user/domain/entity/order_details.dart';
import 'package:quiky_user/features/user/domain/entity/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> login({
    @required String username,
    @required String password,
  });

  Future<Either<Failure, User>> signUp({
    @required String username,
    @required String name,
    @required String password,
  });

  void logout();
  Future<Either<Failure, List<OrderDetails>>> getPastOrders();
  Future<Either<Failure, OrderDetails>> getOrderStatus(int orderId);
}
