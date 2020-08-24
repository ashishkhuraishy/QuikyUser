import 'package:flutter_test/flutter_test.dart';
import 'package:quiky_user/features/cart/data/model/cart_item_model.dart';
import 'package:quiky_user/features/cart/data/model/cart_model.dart';
import 'package:quiky_user/features/cart/domain/entity/cart.dart';
import 'package:quiky_user/features/home/data/model/offer_model.dart';

main() {
  final cartModel = CartModel(storeId: 15, offers: [
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
  ], cartItems: [
    CartItemModel(
      id: 5,
      name: "",
      price: "",
      inStock: true,
      quantity: 5,
    ),
  ]);

  test('should be a subType of [Cart]', () {
    expect(cartModel, isA<Cart>());
  });
}
