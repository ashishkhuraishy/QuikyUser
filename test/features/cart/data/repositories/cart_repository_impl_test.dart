import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quiky_user/features/cart/data/data_sources/cart_local_data_source.dart';
import 'package:quiky_user/features/cart/data/repository/cart_repository_impl.dart';
import 'package:quiky_user/features/products/domain/entity/variation.dart';

class MockCartLocalDataSource extends Mock implements CartLocalDataSource {}

MockCartLocalDataSource mockCartLocalDataSource;
CartRepositoryImpl repositoryImpl;

main() {
  mockCartLocalDataSource = MockCartLocalDataSource();
  repositoryImpl = CartRepositoryImpl(
    localDataSource: mockCartLocalDataSource,
  );

  final tVariation = Variation(
    id: 2,
    image: '',
    title: '',
    color: '',
    weight: '',
    size: '',
    isStock: true,
    price: "200",
    quantity: "5",
    updated: "",
    active: true,
    productId: 56,
  );

  group('Add Item', () {});
}
