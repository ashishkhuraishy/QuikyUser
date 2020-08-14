import 'package:quiky_user/features/cart/data/data_sources/cart_local_data_source.dart';
import 'package:quiky_user/features/cart/data/model/cart_item_model.dart';
import 'package:quiky_user/features/cart/domain/entity/cart.dart';
import 'package:quiky_user/features/cart/domain/repository/cart_repository.dart';
import 'package:quiky_user/features/products/domain/entity/variation.dart';
import 'package:quiky_user/features/home/domain/entity/offer.dart';

class CartRepositoryImpl extends CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepositoryImpl({this.localDataSource});

  @override
  Future<void> addItem(
      {Variation variation, int quantity, int storeId, Offer offer}) async {
    Cart currentCart = await localDataSource.getCart();

    currentCart.cartItems.removeWhere((element) => element.id == variation.id);
    if (quantity != 0) {
      CartItemModel cartItemModel = CartItemModel(
        id: variation.id,
        inStock: variation.isStock,
        name: variation.title,
        price: variation.price,
        quantity: quantity,
      );

      currentCart.cartItems.add(cartItemModel);
    }

    localDataSource.saveCart(currentCart);
  }

  @override
  Future<Cart> getCart() {
    return localDataSource.getCart();
  }
}