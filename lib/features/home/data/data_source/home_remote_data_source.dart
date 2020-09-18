import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:quiky_user/core/error/exception.dart';
import 'package:quiky_user/features/home/data/model/recipie_model.dart';
import 'package:quiky_user/features/home/data/model/restaurant_model.dart';
import 'package:quiky_user/features/home/domain/entity/recipie.dart';

// const BASE_URL = 'http://3.7.65.63';
const BASE_URL = 'https://bf0f1c4ddd91.ngrok.io';

enum StoreType {
  inTheSpotlight,
  popularBrand,
  trendingRestaurants,
  trendingGroceries,
  restaurants,
  groceries,
  books,
  fish,
  meat,
  electronics,
  milk,
}

abstract class HomeRemoteDataSource {
  /// Get the data from the Recipies api and parse them to list
  ///
  /// on failure throw [ServerException]
  Future<List<Recipie>> getRecipies();

  /// Get the list of all [Restaurents] which belongs to a
  /// specific [StoreType] which takes `lat`, `long` and the `storetype`
  ///
  /// throws a [ServerException] on any failed response
  Future<List<RestaurantModel>> getStores({
    @required double lat,
    @required double long,
    @required StoreType storeType,
  });
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final Client client;

  HomeRemoteDataSourceImpl({@required this.client});

  @override
  Future<List<Recipie>> getRecipies() async {
    final recipieUrl = BASE_URL + '/api/recipe/';
    Response response = await client.get(recipieUrl);
    if (response.statusCode == 200) {
      List body = jsonDecode(response.body);
      return body.map<RecipieModel>((e) => RecipieModel.fromJson(e)).toList();
    }
    throw ServerException();
  }

  @override
  Future<List<RestaurantModel>> getStores(
      {double lat, double long, StoreType storeType}) async {
    final url = _generateUrl(storeType, lat, long);
    Response response = await client.get(url);
    if (response.statusCode == 200) {
      List body = jsonDecode(response.body);
      return body
          .map<RestaurantModel>((e) => RestaurantModel.fromJson(e))
          .toList();
    }

    /// `Un-comment these lines for debugging`
    /// print(response.statusCode);
    /// print(response.body);
    throw ServerException();
  }

  /// Helper fn to generate a Url based on the [StoreType]
  String _generateUrl(StoreType storeType, double lat, double lng) {
    String url = BASE_URL + '/store_list/?lat=$lat&lon=$lng&';

    switch (storeType) {
      case StoreType.inTheSpotlight:
        url += 'store_type=food&highlight_status=True';
        break;
      case StoreType.popularBrand:
        url += 'featured_brand=True';
        break;
      case StoreType.trendingRestaurants:
        url += 'filter=trending&store_type=food';
        break;
      case StoreType.trendingGroceries:
        url += 'filter=trending&store_type=grocery';
        break;
      case StoreType.restaurants:
        url += 'store_type=food';
        break;
      case StoreType.groceries:
        url += 'store_type=grocery';
        break;
      case StoreType.books:
        url += 'store_type=books';
        break;
      case StoreType.fish:
        url += 'store_type=fish';
        break;
      case StoreType.meat:
        url += 'store_type=meat';
        break;
      case StoreType.electronics:
        url += 'store_type=electronics';
        break;
      case StoreType.milk:
        url += 'store_type=milk';
        break;
      default:
        break;
    }

    return url;
  }
}
