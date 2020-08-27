import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:quiky_user/features/cart/data/model/cart_item_model.dart';
import 'package:quiky_user/features/cart/domain/entity/cart_item.dart';

import '../../../../fixtures/fixture_reader.dart';

main() {
  final jsondata = jsonDecode(fixture('cart-item.json'));
  final tCartItem = CartItemModel(
    id: 669,
    name: 'Wheat Paratha',
    price: "20.00",
    inStock: true,
    quantity: 2,
  );

  test('should be a subType of [CARTITEM]', () {
    expect(tCartItem, isA<CartItem>());
  });

  test('should return a valid [CARTITEM] model', () {
    final result = CartItemModel.fromJson(jsondata);

    expect(result, tCartItem);
  });

  test('should calculate the Inline total', () {
    expect(tCartItem.inlineTotal, 40.0);
  });
}
