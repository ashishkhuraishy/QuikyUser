import 'package:flutter/cupertino.dart';
import 'package:quiky_user/core/error/exception.dart';
import 'package:quiky_user/core/platform/network_info.dart';
import 'package:quiky_user/features/products/data/data_source/product_remote_data_source.dart';
import 'package:quiky_user/features/products/domain/entity/category.dart';
import 'package:quiky_user/features/products/domain/entity/product.dart';
import 'package:quiky_user/features/products/domain/entity/store_products.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:quiky_user/features/products/domain/repository/products_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final NetworkInfo networkInfo;
  final ProductsRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({
    @required this.networkInfo,
    @required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Category>>> getProducts(int id) async {
    if (!await networkInfo.isConnected) return Left(ConnectionFailure());

    List<Category> _categories;
    StoreProducts _products;
    try {
      _categories = await remoteDataSource.getCategories(id);
      _products = await remoteDataSource.getProducts(id);
    } on ServerException {
      return Left(ServerFailure());
    }

    _categories.forEach((element) {
      List<Product> _temp = _products.products;
      _temp.retainWhere((e) {
        print(e.category.id);
        return e.category.id == element.id;
      });
      print('${element.title} : ${_temp.length}');
      element.addProducts(_temp);
      print(_products.products.length);
      print(_temp.length);
    });

    return Right(_categories);
  }
}
