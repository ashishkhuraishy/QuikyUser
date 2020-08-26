import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/products/domain/entity/category.dart';
import 'package:quiky_user/features/products/domain/repository/products_repository.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts({@required this.repository});

  Future<Either<Failure, List<Category>>> call({@required int id}) async {
    return await repository.getProducts(id);
  }
}
