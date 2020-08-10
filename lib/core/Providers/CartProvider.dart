import 'package:flutter/cupertino.dart';
import 'package:quiky_user/features/cart/domain/entity/cart.dart';
import 'package:quiky_user/features/cart/domain/usecase/add_item.dart';
import 'package:quiky_user/features/cart/domain/usecase/get_cart.dart';
import 'package:quiky_user/features/home/domain/entity/offer.dart';
import 'package:quiky_user/features/products/domain/entity/product.dart';
import 'package:quiky_user/features/products/domain/entity/variation.dart';

import '../../injection_container.dart';

class CartProvider extends ChangeNotifier {
  GetCart _getCart = GetCart(repository: sl());
  AddItem _addItem = AddItem(repository: sl());

  Cart _currentCart = Cart(storeId: null, offers: null, cartItems: null);

  List<Product> get currentProducts => _getProductsFromCart();
  int get currentStoreId => _currentCart.storeId;
  List<Offer> get currentOffers => _currentCart.offers;

  addProducts({Variation variation, Offer offer, int quantity, int storeId}) {
    _addItem.call(
      offer: offer,
      quantity: quantity,
      storeId: storeId,
      variation: variation,
    );

    _updateCart();
  }

  _updateCart() async {
    _currentCart = await _getCart();
    notifyListeners();
  }

  _getProductsFromCart() async {
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

    _updateCart();

    return products;
  }
}
