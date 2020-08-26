import 'package:dartz/dartz.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/products/domain/entity/category.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Category>>> getProducts(int id);
}
