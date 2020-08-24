import 'package:flutter/cupertino.dart';
import 'package:quiky_user/features/cart/data/model/cart_model.dart';
import 'package:quiky_user/features/cart/domain/entity/cart.dart';
import 'package:quiky_user/features/cart/domain/entity/cart_item.dart';
import 'package:quiky_user/features/cart/domain/usecase/add_item.dart';
import 'package:quiky_user/features/cart/domain/usecase/get_cart.dart';
import 'package:quiky_user/features/home/domain/entity/offer.dart';
import 'package:quiky_user/features/products/data/models/product_model.dart';
import 'package:quiky_user/features/products/data/models/variation_model.dart';
import 'package:quiky_user/features/products/domain/entity/product.dart';
import 'package:quiky_user/features/products/domain/entity/variation.dart';

import '../../injection_container.dart';

class CartProvider extends ChangeNotifier {
  GetCart _getCart = GetCart(repository: sl());
  AddItem _addItem = AddItem(repository: sl());

  Cart _currentCart = Cart(storeId: null, offers: null, cartItems: null);

  List<Product> cartProducts = [];

  // List<Product> get currentProducts => _getProductsFromCart();
  Future<Cart> get getCart async => await _getCart.call();
  int get currentStoreId => _currentCart.storeId;
  List<Offer> get currentOffers => _currentCart.offers;
  List<CartItem> get currentCartItems => _currentCart.cartItems;

  /// function used to add an Item into the cart
  /// @requires [VARIATION], quantity for cartItem and
  /// offerDetails and storeId for making things easier
  /// to handle

  addProducts({
    Variation variation,
    List<Offer> offers,
    int quantity,
    int storeId,
  }) {
    _addItem.call(
      offers: offers,
      quantity: quantity,
      storeId: storeId,
      variation: variation,
    );

    _updateCart();
  }

  /// Function to check if a given variation Id is already inside
  /// the [CART] if there is an elemnt it wi;; return [CARTITEM.QUANTITY]
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
    notifyListeners();
  }

  /// Helper Function to convert all cart Items Into [PRODUCT]
  /// for hellping out the front end reusability

  Future<List<Product>> getProductsFromCart() async {
    final res = await _getCart.call();
    List<Product> products = List<Product>();

    res.cartItems.forEach((element) {
      products.add(Product(
        id: null,
        productImages: null,
        variations: [
          Variation(
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
          )
        ],
        productReviews: null,
        productViews: null,
        category: null,
        image: null,
        title: null,
        sku: null,
        tax: null,
        description: null,
        quantity: null,
        discount: null,
        isStock: null,
        isFeatured: null,
        isDiscount: null,
        vegNvEgg: null,
        active: null,
        timestamp: null,
        updated: null,
        user: null,
        filter: null,
      ));
    });

    cartProducts = products;
    _updateCart();
    return products;
  }
}
