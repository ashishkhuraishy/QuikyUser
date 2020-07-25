import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:quiky_user/features/products/data/models/product_model.dart';
import 'package:quiky_user/features/products/domain/entity/product.dart';

import '../../../../fixtures/fixture_reader.dart';

main() {
  test('should return a valid ProductModel from the json', () {
    final data = jsonDecode(fixture('products.json'));

    final result = ProductModel.fromJson(data);
    expect(result, isA<Product>());
    expect(result, isA<ProductModel>());
  });
}
