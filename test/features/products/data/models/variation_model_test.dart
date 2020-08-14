import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:quiky_user/features/products/data/models/variation_model.dart';
import 'package:quiky_user/features/products/domain/entity/variation.dart';

import '../../../../fixtures/fixture_reader.dart';

main() {
  final variationModel = VariationModel(
    id: 28,
    image: '',
    title: '',
    color: '',
    weight: '',
    size: '',
    isStock: true,
    price: '300.0',
    quantity: '',
    updated: '2020-06-21T22:24:19.660364+05:30',
    active: true,
    productId: 38,
  );

  test('should be subType of Variation', () {
    expect(variationModel, isA<Variation>());
  });

  test('should return a valid VariationModel from the json', () {
    final data = jsonDecode(fixture('variation.json'));

    final result = VariationModel.fromJson(data);
    expect(result, isA<VariationModel>());
  });
}
