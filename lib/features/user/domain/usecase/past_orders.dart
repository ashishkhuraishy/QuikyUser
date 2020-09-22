import 'package:dartz/dartz.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/user/domain/entity/order_details.dart';
import 'package:quiky_user/features/user/domain/repository/user_repository.dart';

class PastOrders {
  final UserRepository repository;

  PastOrders(this.repository);

  Future<Either<Failure, List<OrderDetails>>> call() {
    return repository.getPastOrders();
  }
}
