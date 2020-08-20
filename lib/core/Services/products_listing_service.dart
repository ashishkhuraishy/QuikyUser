import 'package:quiky_user/features/products/domain/entity/category.dart';
import 'package:quiky_user/features/products/domain/usecase/get_products..dart';

import '../../injection_container.dart';

class ProductListingService {
  final int id;

  GetProducts _getProducts = GetProducts(repository: sl());

  ProductListingService({this.id});

  Future<List<Category>> get getCategories async {
    // print("id $id");
    final resultOrError = await _getProducts(id: this.id);
    List<Category> _result;

    resultOrError.fold((l) {
      _result = null;
      print('${l.runtimeType} error occured while calling GetProducts');
    }, (products) => _result = products);
    // print(_result);
    return _result;
  }
}
