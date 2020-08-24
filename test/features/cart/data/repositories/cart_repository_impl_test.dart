import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quiky_user/features/cart/data/data_sources/cart_local_data_source.dart';
import 'package:quiky_user/features/cart/data/repository/cart_repository_impl.dart';
import 'package:quiky_user/features/cart/domain/entity/cart.dart';
import 'package:quiky_user/features/cart/domain/entity/cart_item.dart';
import 'package:quiky_user/features/home/domain/entity/offer.dart';
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

  final tVariation2 = Variation(
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

  final tQuantity = 5;
  final tSToreId = 3;
  final tOffers = [
    Offer(
      id: 56,
      title: "Test Code",
      code: "test123",
      text: "test Coupon",
      offerId: 6,
      percentage: "40%",
    )
  ];

  final tCartItem = CartItem(
    id: tVariation.id,
    name: tVariation.title,
    price: tVariation.price,
    inStock: tVariation.isStock,
    quantity: tQuantity,
  );

  final tCart = Cart(
    storeId: tSToreId,
    offers: tOffers,
    cartItems: [
      tCartItem,
    ],
  );

  final tEmptyCart = Cart(
    storeId: -1,
    offers: [],
    cartItems: [],
  );

  group('Add Item', () {
    test('should create and save a new [CART] when the `storeId` dont match',
        () async {
      when(mockCartLocalDataSource.getCart())
          .thenAnswer((realInvocation) async => tEmptyCart);

      await repositoryImpl.addItem(
        variation: tVariation,
        offers: tOffers,
        quantity: tQuantity,
        storeId: tSToreId,
      );

      verify(mockCartLocalDataSource.saveCart(tCart));
    });
  });
}
