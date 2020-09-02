import 'package:dartz/dartz.dart' as dz;

import '../../../../core/error/failure.dart';
import '../entity/order.dart';
import '../repository/cart_repository.dart';

class ConfirmOrder {
  final CartRepository repository;

  ConfirmOrder({this.repository});

  Future<dz.Either<Failure, Order>> call(
      {String userLocation, String coupon}) async {
    return await repository.confirmorder(
      userlocation: userLocation,
      coupon: coupon,
    );
  }
}
