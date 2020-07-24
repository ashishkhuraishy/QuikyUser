import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:quiky_user/core/error/exception.dart';
import 'package:quiky_user/features/home/data/model/recipie_model.dart';
import 'package:quiky_user/features/home/data/model/restaurant_model.dart';
import 'package:quiky_user/features/home/domain/entity/recipie.dart';

const BASE_URL = 'http://3.7.65.63';

abstract class HomeRemoteDataSource {
  /// Get the data from the Recipies api and parse them to list
  ///
  /// on failure throw [ServerException]
  Future<List<Recipie>> getRecipies();
  Future<List<RestaurantModel>> getFeatured({
    @required double lat,
    @required double long,
  });
  Future<List<RestaurantModel>> getPopular({
    @required double lat,
    @required double long,
  });
  Future<List<RestaurantModel>> getTrendingRestaurents({
    @required double lat,
    @required double long,
  });
  Future<List<RestaurantModel>> getTrendingGrocery({
    @required double lat,
    @required double long,
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
    } else
      throw ServerException();
  }

  @override
  Future<List<RestaurantModel>> getFeatured({double lat, double long}) async {
    final url = BASE_URL +
        '/store_list/' +
        '?lat=$lat&lon=$long&featured_brand=true&store_type=food';
    Response response = await client.get(url);
    if (response.statusCode == 200) {
      List body = jsonDecode(response.body);
      return body
          .map<RestaurantModel>((e) => RestaurantModel.fromJson(e))
          .toList();
    } else
      throw ServerException();
  }

  @override
  Future<List<RestaurantModel>> getPopular({double lat, double long}) async {
    final url =
        BASE_URL + '/store_list/' + '?lat=$lat&lon=$long&popular_brand=true';
    Response response = await client.get(url);
    if (response.statusCode == 200) {
      List body = jsonDecode(response.body);
      return body
          .map<RestaurantModel>((e) => RestaurantModel.fromJson(e))
          .toList();
    } else
      throw ServerException();
  }

  @override
  Future<List<RestaurantModel>> getTrendingGrocery(
      {double lat, double long}) async {
    final url = BASE_URL +
        '/store_list/' +
        '?lat=$lat&lon=$long&option=trending&store_type=grocery';
    Response response = await client.get(url);
    if (response.statusCode == 200) {
      List body = jsonDecode(response.body);
      return body
          .map<RestaurantModel>((e) => RestaurantModel.fromJson(e))
          .toList();
    } else
      throw ServerException();
  }

  @override
  Future<List<RestaurantModel>> getTrendingRestaurents(
      {double lat, double long}) async {
    final url = BASE_URL +
        '/store_list/' +
        '?lat=$lat&lon=$long&option=trending&store_type=food';
    Response response = await client.get(url);
    if (response.statusCode == 200) {
      List body = jsonDecode(response.body);
      return body
          .map<RestaurantModel>((e) => RestaurantModel.fromJson(e))
          .toList();
    } else
      throw ServerException();
  }
}
