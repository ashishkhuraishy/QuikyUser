import 'dart:convert';

import 'package:http/http.dart';

import '../../../../Constants/Apikeys.dart';
import '../../../../core/error/exception.dart';
import '../../../home/data/model/restaurant_model.dart';
import '../../../home/domain/entity/restaurents.dart';

abstract class SearchRemoteDataSource {
  /// Checks the search api and converts the response
  /// into list of [Restaurent] and returns
  ///
  /// throws [ServerException] in case of error
  Future<List<Restaurant>> getResults(String query, double lat, double lng);
}

class SearchRemoteDataSourceImpl extends SearchRemoteDataSource {
  final Client client;

  SearchRemoteDataSourceImpl({this.client});

  @override
  Future<List<Restaurant>> getResults(
      String query, double lat, double lng) async {
    final url = BASE_URL + "/search/?lat=$lat&lon=$lng&search=$query";

    Response response = await client.get(url);
    if (response.statusCode == 200) {
      List body = jsonDecode(response.body);
      return body
          .map<RestaurantModel>((e) => RestaurantModel.fromJson(e))
          .toList();
    }
    throw ServerException();
  }
}
