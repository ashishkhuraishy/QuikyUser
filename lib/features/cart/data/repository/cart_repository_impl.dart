import 'package:dartz/dartz.dart' as drtz;

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/platform/network_info.dart';
import '../../../home/domain/entity/restaurents.dart';
import '../../../products/domain/entity/variation.dart';
import '../../domain/entity/cart.dart';
import '../../domain/entity/cart_item.dart';
import '../../domain/entity/order.dart';
import '../../domain/repository/cart_repository.dart';
import '../data_sources/cart_local_data_source.dart';
import '../data_sources/cart_remote_data_source.dart';

class CartRepositoryImpl extends CartRepository {
  final CartLocalDataSource localDataSource;
  final CartRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  CartRepositoryImpl({
    this.localDataSource,
    this.remoteDataSource,
    this.networkInfo,
  });

  @override
  Future<Cart> addItem({
    Variation variation,
    int quantity,
    Restaurant restaurant,
  }) async {
    Cart currentCart = await localDataSource.getCart();

    if (currentCart.storeId == restaurant.id) {
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
        storeId: restaurant.id,
        offers: restaurant.offers,
        storeAddress: restaurant.address,
        storeLogo: restaurant.brandLogo,
        storeImage: restaurant.profilePicture,
        storeName: restaurant.title,
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
    return currentCart;
  }

  @override
  Future<Cart> getCart() {
    return localDataSource.getCart();
  }

  @override
  void clear() {
    localDataSource.saveCart(
      Cart(
        storeId: -1,
        storeName: "",
        storeAddress: "",
        storeLogo: "",
        storeImage: "",
        offers: [],
        cartItems: [],
      ),
    );
  }

  @override
  Future<drtz.Either<Failure, Order>> confirmorder({
    String userlocation,
    String coupon,
  }) async {
    if (!(await networkInfo.isConnected)) return drtz.Left(ConnectionFailure());
    Cart currentCart = await localDataSource.getCart();

    try {
      final token = localDataSource.getToken();
      Order order = await remoteDataSource.confirmOrder(
        currentCart,
        token: token,
        userLocation: userlocation,
        coupon: coupon,
      );
      localDataSource.setOrderId(order.id);
      return drtz.Right(order);
    } on UserException {
      return drtz.Left(UserFailure());
    } on ServerException {
      return drtz.Left(ServerFailure());
    }
  }
}
