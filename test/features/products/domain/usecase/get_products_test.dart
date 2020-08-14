import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quiky_user/features/products/domain/entity/category.dart';
import 'package:quiky_user/features/products/domain/repository/products_repository.dart';
import 'package:quiky_user/features/products/domain/usecase/get_products..dart';

class MockProductRepository extends Mock implements ProductRepository {}

main() {
  MockProductRepository mockProductRepository;
  GetProducts getProducts;

  setUp(() {
    mockProductRepository = MockProductRepository();
    getProducts = GetProducts(repository: mockProductRepository);
  });
  final categories = [
    Category(id: null, imgUrl: null, title: null, userId: null),
    Category(id: null, imgUrl: null, title: null, userId: null),
    Category(id: null, imgUrl: null, title: null, userId: null),
    Category(id: null, imgUrl: null, title: null, userId: null),
  ];

  test('should return a StoreProduct from the response', () async {
    when(mockProductRepository.getProducts(any))
        .thenAnswer((realInvocation) async => Right(categories));

    final result = await getProducts(id: 5);
    verify(mockProductRepository.getProducts(5));
    expect(result, Right(categories));
  });
}
