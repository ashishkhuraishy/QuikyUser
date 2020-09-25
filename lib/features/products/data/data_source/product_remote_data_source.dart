import 'dart:convert';

import 'package:http/http.dart';

import '../../../../Constants/Apikeys.dart';
import '../../../../core/error/exception.dart';
import '../../domain/entity/category.dart';
import '../../domain/entity/store_products.dart';
import '../models/category_model.dart';
import '../models/store_product_models.dart';

abstract class ProductsRemoteDataSource {
  /// Get all the categories associated with a Store
  ///
  ///  if response is not 200 throw a [ServerException]
  Future<List<Category>> getCategories(int id);

  /// Get all the Products associated with a Store
  ///
  ///  if response is not 200 throw a [ServerException]
  Future<StoreProducts> getProducts(int id);
}

class ProductsRemoteDataSourceImpl extends ProductsRemoteDataSource {
  final Client client;

  ProductsRemoteDataSourceImpl({this.client});

  @override
  Future<List<Category>> getCategories(int id) async {
    final url = BASE_URL + '/category_list/$id/';
    Response response = await client.get(url);
    if (response.statusCode == 200) {
      List body = jsonDecode(response.body);
      return body.map<CategoryModel>((e) => CategoryModel.fromJson(e)).toList();
    } else
      throw ServerException();
  }

  @override
  Future<StoreProducts> getProducts(int id) async {
    final url = BASE_URL + '/product_list/?store_id=$id';
    Response response = await client.get(url);
    if (response.statusCode == 200) {
      Map body = jsonDecode(response.body);
      // print(body);
      return StoreProductsModel.fromJson(body);
    } else {
      throw ServerException();
    }
  }
}
