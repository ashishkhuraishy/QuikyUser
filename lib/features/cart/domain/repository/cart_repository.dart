import '../../../home/domain/entity/restaurents.dart';
import '../../../products/domain/entity/variation.dart';
import '../entity/cart.dart';

abstract class CartRepository {
  Future<Cart> addItem({
    Variation variation,
    int quantity,
    Restaurant restaurant,
  });

  Future<Cart> getCart();

  void clear();
}
