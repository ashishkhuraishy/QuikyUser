import 'package:quiky_user/features/cart/domain/entity/cart.dart';
import 'package:quiky_user/features/cart/domain/entity/cart_item.dart';

import '../../../home/domain/entity/offer.dart';
import '../../../products/domain/entity/variation.dart';
import '../../domain/repository/cart_repository.dart';
import '../data_sources/cart_local_data_source.dart';
import '../model/cart_item_model.dart';
import '../model/cart_model.dart';

class CartRepositoryImpl extends CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepositoryImpl({this.localDataSource});

  @override
  Future<void> addItem(
      {Variation variation,
      int quantity,
      int storeId,
      List<Offer> offers}) async {
    Cart currentCart = await localDataSource.getCart();

    if (currentCart.storeId == storeId) {
      currentCart.cartItems
          .removeWhere((element) => element.id == variation.id);
      if (quantity != 0) {
        CartItem cartItemModel = CartItem(
          id: variation.id,
          inStock: variation.isStock,
          name: variation.title,
          price: variation.price,
          quantity: quantity,
        );
        currentCart.cartItems.add(cartItemModel);
      }
    } else {
      currentCart = Cart(
        storeId: storeId,
        offers: offers,
        cartItems: [
          CartItem(
            id: variation.id,
            name: variation.title,
            price: variation.price,
            inStock: variation.isStock,
            quantity: quantity,
          )
        ],
      );
    }

    localDataSource.saveCart(currentCart);
  }

  @override
  Future<CartModel> getCart() {
    return localDataSource.getCart();
  }
}
