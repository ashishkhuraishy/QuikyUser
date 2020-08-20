import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:quiky_user/features/home/data/model/offer_model.dart';
import 'package:quiky_user/features/home/data/model/restaurant_model.dart';
import 'package:quiky_user/features/home/domain/entity/restaurents.dart';

import '../../../../fixtures/fixture_reader.dart';

main() {
  final restaurentModel = RestaurantModel(
    id: 25,
    offers: [
      OfferModel(
        id: 1,
        title: 'Quicky50',
        code: 'quick',
        text: '',
        offerId: 3,
        percentage: '40',
      ),
    ],
    employeeId: "97632",
    title: "MRA Bakery And Restaurant",
    mobile: "85930 12345",
    gst: '',
    tinTan: '',
    typeGoods: "food",
    delivery: false,
    vendor: true,
    customer: false,
    popularBrand: true,
    brandLogo: "/media/images.png",
    profilePicture: "/media/8.png",
    fssai: "11319007002211",
    storeSubType: "Indian, Chinese",
    status: "opened",
    option: "trending",
    totalReviews: "",
    avgRating: '',
    coordinate: "10.0142468,76.2775775",
    address:
        "ARRA-96 Cheranalllur Road Bypass Junction, Ponekkara, Edappally, Opposite lulu mall, Kochi, Kerala 682024",
    recommendationCount: '',
    minimumCostTwo: '450',
    avgDeliveryTime: "4.5",
    active: true,
    inOrder: false,
    bulkOrder: false,
    opening: '',
    closing: '',
    highlightStatus: true,
    featuredBrand: true,
    commisionPercentage: '',
    user: "37",
    city: "1",
    zone: '',
    vendorLocation: "10.0142468,76.2775775",
  );

  test('should be subType of Restaurant', () {
    expect(restaurentModel, isA<Restaurant>());
  });

  test('should return a valid RestaurentModel from the json', () {
    final data = jsonDecode(fixture('restaurant.json'));

    final result = RestaurantModel.fromJson(data);
    expect(result, restaurentModel);
  });

  test('should return a valid List<RestaurentModel> from the json', () {
    List data = jsonDecode(fixture('brands.json'));

    final result =
        data.map<RestaurantModel>((e) => RestaurantModel.fromJson(e)).toList();
    expect(result, isA<List<RestaurantModel>>());
  });
}
