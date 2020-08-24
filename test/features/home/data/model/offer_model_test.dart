import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:quiky_user/features/home/data/model/offer_model.dart';
import 'package:quiky_user/features/home/domain/entity/offer.dart';

import '../../../../fixtures/fixture_reader.dart';

main() {
  final recipieModel = OfferModel(
    id: 1,
    title: 'Quicky50',
    code: 'quick',
    text: '',
    offerId: 3,
    percentage: '40',
  );

  test('should be subType of Offer', () {
    expect(recipieModel, isA<Offer>());
  });

  test('should return a valid OfferModel from the json', () {
    final data = jsonDecode(fixture('offer.json'));

    final result = OfferModel.fromJson(data);
    expect(result, recipieModel);
  });
}
