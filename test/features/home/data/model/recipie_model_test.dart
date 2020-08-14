import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:quiky_user/features/home/data/model/recipie_model.dart';
import 'package:quiky_user/features/home/domain/entity/recipie.dart';

import '../../../../fixtures/fixture_reader.dart';

main() {
  RecipieModel recipieModel = RecipieModel(
    id: 1,
    title: 'test filter',
    imgUrl: 'http://3.7.65.63/media/1_BitcONx.jpg',
    stores: [1],
  );

  test('should be subType of Recipie', () {
    expect(recipieModel, isA<Recipie>());
  });

  test('should return a valid RecipieModel from the json', () {
    final data = jsonDecode(fixture('recipies.json'));

    final result = RecipieModel.fromJson(data[0]);
    expect(result, recipieModel);
  });
}
