import 'package:dartz/dartz.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/user/domain/entity/order_details.dart';
import 'package:quiky_user/features/user/domain/repository/user_repository.dart';

class OrderStatus {
  final UserRepository repository;

  OrderStatus(this.repository);

  Future<Either<Failure, OrderDetails>> call(int orderId) {
    return repository.getOrderStatus(orderId);
  }
}
