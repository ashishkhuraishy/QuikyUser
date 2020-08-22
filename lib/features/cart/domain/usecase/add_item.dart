import 'package:quiky_user/features/cart/domain/repository/cart_repository.dart';
import 'package:quiky_user/features/home/data/model/offer_model.dart';
import 'package:quiky_user/features/home/domain/entity/offer.dart';
import 'package:quiky_user/features/products/domain/entity/variation.dart';

class AddItem {
  final CartRepository repository;

  AddItem({this.repository});

  Future<void> call({
    Variation variation,
    int quantity,
    int storeId,
    List<Offer> offers,
  }) async {
    return await repository.addItem(
      offers: offers,
      quantity: quantity,
      storeId: storeId,
      variation: variation,
    );
  }
}
