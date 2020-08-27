import 'package:flutter_test/flutter_test.dart';
import 'package:quiky_user/features/cart/data/model/cart_item_model.dart';
import 'package:quiky_user/features/cart/data/model/cart_model.dart';
import 'package:quiky_user/features/cart/domain/entity/cart.dart';
import 'package:quiky_user/features/home/data/model/offer_model.dart';

main() {
  final cartModel = CartModel(
    storeId: 15,
    storeName: "Test Store",
    storeAddress: "Test Address",
    offers: [
      OfferModel(
        id: 0,
        title: "",
        code: "",
        text: "",
        offerId: 27,
        percentage: "40%",
      ),
      OfferModel(
        id: 0,
        title: "",
        code: "",
        text: "",
        offerId: 27,
        percentage: "40%",
      ),
      OfferModel(
        id: 0,
        title: "",
        code: "",
        text: "",
        offerId: 27,
        percentage: "40%",
      ),
    ],
    cartItems: [
      CartItemModel(
        id: 5,
        name: "",

        price: "10.0",
        inStock: true,
        quantity: 10,
      ),
      CartItemModel(
        id: 9,
        name: "",
        price: "25.0",
        inStock: true,
        quantity: 4,
      ),
      CartItemModel(
        id: 11,
        name: "",
        price: "100.0",
        inStock: true,
        quantity: 3,
      ),
    ],
  );

  test('should be a subType of [Cart]', () {
    expect(cartModel, isA<Cart>());
  });

  test('should return the total while calling the getter method', () {
    expect(cartModel.total, 500.0);
  });
}
