import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:quiky_user/core/error/exception.dart';
import 'package:quiky_user/features/home/data/model/recipie_model.dart';
import 'package:quiky_user/features/home/domain/entity/recipie.dart';

abstract class HomeRemoteDataSource {
  /// Get the data from the Recipies api and parse them to list
  ///
  /// on failure throw [ServerException]
  Future<List<Recipie>> getRecipies();
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final Client client;

  HomeRemoteDataSourceImpl({@required this.client});

  @override
  Future<List<Recipie>> getRecipies() async {
    // TODO: implement getRecipies
    final recipieUrl = 'http://3.7.65.63/api/recipe/';
    Response response = await client.get(recipieUrl);
    if (response.statusCode == 200) {
      List body = jsonDecode(response.body);
      return body.map<RecipieModel>((e) => RecipieModel.fromJson(e)).toList();
    } else
      throw ServerException();
  }
}
