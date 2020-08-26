import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:quiky_user/features/products/data/models/category_model.dart';
import 'package:quiky_user/features/products/domain/entity/category.dart';

import '../../../../fixtures/fixture_reader.dart';

main() {
  test('should return a valid CategoryModel from the json', () {
    final data = jsonDecode(fixture('category.json'));

    final result = CategoryModel.fromJson(data);
    expect(result, isA<Category>());
    expect(result, isA<CategoryModel>());
  });
}
