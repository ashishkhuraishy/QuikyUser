import '../entity/cart.dart';
import '../repository/cart_repository.dart';
import '../../../home/domain/entity/restaurents.dart';
import '../../../products/domain/entity/variation.dart';

class AddItem {
  final CartRepository repository;

  AddItem({this.repository});

  Future<Cart> call({
    Variation variation,
    int quantity,
    Restaurant restaurant,
  }) async {
    return await repository.addItem(
      quantity: quantity,
      restaurant: restaurant,
      variation: variation,
    );
  }
}
