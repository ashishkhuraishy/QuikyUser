import 'package:quiky_user/features/cart/domain/entity/cart.dart';
import 'package:quiky_user/features/home/domain/entity/offer.dart';
import 'package:quiky_user/features/products/domain/entity/variation.dart';

abstract class CartRepository {
  Future<void> addItem(
      {Variation variation, int quantity, int storeId, Offer offer});

  Future<Cart> getCart();
}
