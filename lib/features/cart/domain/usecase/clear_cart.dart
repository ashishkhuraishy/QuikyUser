import 'package:quiky_user/features/cart/domain/repository/cart_repository.dart';

class ClearCart {
  final CartRepository repository;

  ClearCart({this.repository});

  call() {
    repository.clear();
  }
}
