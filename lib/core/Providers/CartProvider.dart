import 'package:flutter/cupertino.dart';
import 'package:quiky_user/features/cart/domain/usecase/confirm_order.dart';
import 'package:quiky_user/features/home/domain/entity/restaurents.dart';

import '../../features/cart/domain/entity/cart.dart';
import '../../features/cart/domain/entity/cart_item.dart';
import '../../features/cart/domain/usecase/add_item.dart';
import '../../features/cart/domain/usecase/clear_cart.dart';
import '../../features/cart/domain/usecase/get_cart.dart';
import '../../features/home/domain/entity/offer.dart';
import '../../features/products/domain/entity/variation.dart';
import '../../injection_container.dart';

class CartProvider extends ChangeNotifier {
  GetCart _getCart = GetCart(repository: sl());
  AddItem _addItem = AddItem(repository: sl());
  ClearCart _clearCart = ClearCart(repository: sl());
  ConfirmOrder _confirmOrder = ConfirmOrder(repository: sl());

  Cart _currentCart = Cart(
    storeId: -1,
    storeName: "",
    storeAddress: "",
    offers: [],
    cartItems: [],
  );

  List<Variation> cartProducts = [];

  CartProvider() {
    // Initialising the Cart
    _updateCart();
  }

  // List<Product> get currentProducts => _getProductsFromCart();
  Future<Cart> get getCart async => await _getCart.call();
  int get currentStoreId => _currentCart.storeId;
  List<Offer> get currentOffers => _currentCart.offers;
  List<CartItem> get currentCartItems => _currentCart.cartItems;
  void get clear{ 
    _clearCart.call();
    notifyListeners();
  }

  /// function used to add an Item into the cart
  /// @requires [VARIATION], quantity for cartItem and
  /// offerDetails and storeId for making things easier
  /// to handle

  addProducts({
    Variation variation,
    int quantity,
    Restaurant restaurant,

    // TODO : Remove this two lines
    List<Offer> offers,
    int storeId,
  }) {
    _addItem.call(
      quantity: quantity,
      variation: variation,
      restaurant: restaurant,
    );

    _updateCart();
  }

  /// Function to Confirm the current cart which takes in
  /// `UserLocation` and `Coupon` then on Sucess return an
  /// [ORDER] which contains total amount and other details
  ///
  /// on Failure returns [ConnectionFailure] or [ServerFailure]
  /// depending on the error
  confrimOrder({String userLocation, String coupon}) async {
    final result = await _confirmOrder(
      userLocation: userLocation,
      coupon: coupon,
    );

    // TODO : Change this and PUSH

    result.fold(
      (failure) => print(failure),
      (order) => print(order),
    );
  }

  /// Function to check if a given variation Id is already inside
  /// the [CART] if there is an element it will return [CARTITEM.QUANTITY]
  /// else will return -1

  int getQuantity(int id) {
    final cartItem = currentCartItems.firstWhere(
      (element) => element.id == id,
      orElse: () => null,
    );

    if (cartItem != null) return cartItem.quantity;

    return -1;
  }

  /// Helper Function Invoked to update the cart
  _updateCart() async {
    _currentCart = await _getCart();
    // cartProducts = await getProductsFromCart();
    notifyListeners();
  }

  /// Helper Function to convert all cart Items Into [PRODUCT]
  /// for hellping out the front end reusability

  Future<List<Variation>> getProductsFromCart() async {
    final res = await _getCart.call();
    List<Variation> products = List<Variation>();

    res.cartItems.forEach((element) {
      products.add(Variation(
        id: element.id,
        image: null,
        title: element.name,
        color: null,
        weight: null,
        size: null,
        isStock: element.inStock,
        price: element.price,
        quantity: null,
        updated: null,
        active: null,
        productId: null,
      ));
    });

    cartProducts = products;
    _updateCart();
    return products;
  }
}
