import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../home/domain/entity/restaurents.dart';
import '../../../products/domain/entity/variation.dart';
import '../entity/cart.dart';
import '../entity/order.dart' as order;

abstract class CartRepository {
  Future<Cart> addItem({
    Variation variation,
    int quantity,
    Restaurant restaurant,
  });

  Future<Cart> getCart();
  Future<Either<Failure, order.Order>> confirmorder({
    String userlocation,
    String coupon,
  });

  void clear();
}
