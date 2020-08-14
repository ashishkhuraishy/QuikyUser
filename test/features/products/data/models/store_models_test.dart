import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:quiky_user/features/products/data/models/store_product_models.dart';
import 'package:quiky_user/features/products/domain/entity/store_products.dart';

import '../../../../fixtures/fixture_reader.dart';

main() {
  test('should return a valid StoreProductsModel from the json', () {
    final data = jsonDecode(fixture('store-products.json'));

    final result = StoreProductsModel.fromJson(data);
    expect(result, isA<StoreProducts>());
    expect(result, isA<StoreProductsModel>());
  });
}
