import 'package:quiky_user/features/cart/data/model/cart_model.dart';
import 'package:quiky_user/features/cart/domain/entity/cart.dart';
import 'package:quiky_user/features/cart/domain/repository/cart_repository.dart';

class GetCart {
  final CartRepository repository;

  GetCart({this.repository});

  Future<CartModel> call() async {
    return await repository.getCart();
  }
}
