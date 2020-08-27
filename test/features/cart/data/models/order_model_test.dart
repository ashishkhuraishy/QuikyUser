import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:quiky_user/features/cart/data/model/cart_item_model.dart';
import 'package:quiky_user/features/cart/data/model/order_model.dart';
import 'package:quiky_user/features/cart/domain/entity/order.dart';

import '../../../../fixtures/fixture_reader.dart';

main() {
  final jsondata = jsonDecode(fixture('confirm-order.json'));
  final tCartItem1 = CartItemModel(
    id: 669,
    name: 'Wheat Paratha',
    price: "20.00",
    inStock: true,
    quantity: 2,
  );

  final tCartItem2 = CartItemModel(
    id: 668,
    name: 'Kerala Paratha',
    price: "20.00",
    inStock: true,
    quantity: 2,
  );

  final tOrder = OrderModel(
    id: 80,
    items: [
      tCartItem1,
      tCartItem2,
    ],
    total: "184.00",
    subTotal: "80.00",
    delCharges: "100.00",
    taxtotal: "4.00",
    discountAmount: "0.00",
    coupon: "nill",
  );

  test('should be a subType of [ORDER]', () {
    expect(tOrder, isA<Order>());
  });

  test('should return a valid [CARTITEM] model', () {
    final result = OrderModel.fromJson(jsondata);

    expect(result, tOrder);
  });
}
