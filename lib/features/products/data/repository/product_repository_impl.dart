import 'package:flutter/cupertino.dart';
import 'package:quiky_user/core/error/exception.dart';
import 'package:quiky_user/core/platform/network_info.dart';
import 'package:quiky_user/features/products/data/data_source/product_remote_data_source.dart';
import 'package:quiky_user/features/products/data/models/category_model.dart';
import 'package:quiky_user/features/products/domain/entity/category.dart';
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

    /// TODO : check if categories is needed
    // List<Category> _categories;
    StoreProducts _products;
    try {
      // _categories = await remoteDataSource.getCategories(id);
      _products = await remoteDataSource.getProducts(id);
    } on ServerException {
      return Left(ServerFailure());
    }

    // _categories.forEach((element) {
    //   List<Product> _temp = _products.products;
    //   _temp.retainWhere((e) {
    //     // print(e.category.id);
    //     return e.category.id == element.id;
    //   });
    //   // print('${element.title} : ${_temp.length}');
    //   element.addProducts(_temp);
    //   // print(_products.products.length);
    //   // print(_temp.length);
    // });

    List<Category> c = [];

    _products.products.forEach((product) {
      final itemIndex =
          c.indexWhere((element) => element.id == product.category.id);
      if (itemIndex == -1) {
        c.add(
          new CategoryModel(
            id: product.category.id,
            imgUrl: product.category.imgUrl,
            title: product.category.title,
            userId: product.category.userId,
            produts: [product],
          ),
        );
      } else {
        c[itemIndex].produts.add(product);
      }
    });

    return Right(c);
  }
}
