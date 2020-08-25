import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:quiky_user/features/cart/data/data_sources/cart_local_data_source.dart';
import 'package:quiky_user/features/cart/data/model/cart_item_model.dart';
import 'package:quiky_user/features/cart/data/model/cart_model.dart';
import 'package:quiky_user/features/user/data/datasource/user_local_data_source.dart';

class MockHive extends Mock implements HiveInterface {}

class MockBox extends Mock implements Box {}

main() {
  MockHive mockHive = MockHive();
  CartLocalDataSource localDataSource = CartLocalDataSourceImpl(hive: mockHive);

  MockBox mockBox = MockBox();

  final tCartModel = CartModel(
    storeId: 5,
    offers: [],
    storeName: "Test Name",
    storeAddress: "Test Address",
    cartItems: [
      CartItemModel(
        id: 45,
        name: "Test",
        price: "50.0",
        inStock: true,
        quantity: 5,
      ),
    ],
  );

  final tEmptyCart = CartModel(
    storeId: -1,
    storeAddress: "",
    storeName: "",
    offers: [],
    cartItems: [],
  );

  group('Save Cart', () {
    setUp(() {
      when(mockHive.isBoxOpen(any)).thenAnswer((realInvocation) => true);
      when(mockHive.box(any)).thenAnswer((realInvocation) => mockBox);
    });

    test('should open the box if it is closed', () async {
      when(mockHive.isBoxOpen(any)).thenAnswer((realInvocation) => false);

      final result = await localDataSource.saveCart(tCartModel);
      verify(mockHive.openBox(CORE_BOX));
      expect(result, true);
    });

    test('should put the cart into the box as [CART]', () async {
      await localDataSource.saveCart(tCartModel);
      verify(mockBox.put(CART, tCartModel));
    });
  });

  group('Get Cart', () {
    setUp(() {
      when(mockHive.isBoxOpen(any)).thenAnswer((realInvocation) => true);
      when(mockHive.box(any)).thenAnswer((realInvocation) => mockBox);
      when(mockBox.get(
        any,
        defaultValue: anyNamed('defaultValue'),
      )).thenAnswer((realInvocation) => tCartModel);
    });

    test('should open the box if it is closed', () async {
      when(mockHive.isBoxOpen(CORE_BOX)).thenAnswer((realInvocation) => false);

      final result = await localDataSource.saveCart(tCartModel);
      verify(mockHive.openBox(CORE_BOX));
      expect(result, true);
    });

    test(
        'should return an empty [CARTMODEL] with `storeId = -1` when [CART] is empty',
        () async {
      when(
        mockBox.get(
          any,
          defaultValue: anyNamed('defaultValue'),
        ),
      ).thenAnswer((realInvocation) => tEmptyCart);
      final result = await localDataSource.getCart();
      expect(result, isA<CartModel>());
      expect(result, tEmptyCart);
    });

    test('should return a valid [CartModel] when the cart is called', () async {
      final result = await localDataSource.getCart();
      expect(result, tCartModel);
    });
  });
}
