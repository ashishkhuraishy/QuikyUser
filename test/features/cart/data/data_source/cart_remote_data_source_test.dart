import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:quiky_user/core/error/exception.dart';
import 'package:quiky_user/features/cart/data/data_sources/cart_remote_data_source.dart';
import 'package:quiky_user/features/cart/data/model/cart_item_model.dart';
import 'package:quiky_user/features/cart/data/model/order_model.dart';
import 'package:quiky_user/features/cart/domain/entity/cart.dart';
import 'package:quiky_user/features/home/data/data_source/home_remote_data_source.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockClient extends Mock implements Client {}

main() {
  MockClient mockClient = MockClient();
  CartRemoteDataSourceImpl remoteDataSourceImpl = CartRemoteDataSourceImpl(
    client: mockClient,
  );

  final tUserLocation = "10.365581,77.970657";
  final tCoupon = "quicky50";

  final tCartItem1 = CartItemModel(
    id: 669,
    name: 'Wheat Paratha',
    price: "20.00",
    inStock: true,
    quantity: 2,
  );

  final tCartItem2 = CartItemModel(
    id: 668,
    name: 'Kerala Paratha',
    price: "20.00",
    inStock: true,
    quantity: 2,
  );

  final tCart = Cart(
    storeId: 80,
    offers: [],
    cartItems: [
      tCartItem1,
      tCartItem2,
    ],
    storeName: "Test store",
    storeAddress: "Test address",
    storeImage: "Test Image",
    storeLogo: "Test Logo",
  );

  final tOrder = OrderModel(
    id: 80,
    items: [
      tCartItem1,
      tCartItem2,
    ],
    total: "184.00",
    subTotal: "80.00",
    delCharges: "100.00",
    taxtotal: "4.00",
    discountAmount: "0.00",
    coupon: "nill",
  );

  Map<String, dynamic> body = {
    "store_id": "80",
    "cart_item": [
      {"variation": "669", "quantity": "2"},
      {"variation": "668", "quantity": "2"},
    ],
  };

  group('Confirm Order', () {
    setUp(() {
      when(
        mockClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (realInvocation) async => Response(fixture('confirm-order.json'), 200),
      );
    });

    test('should add userLocation & coupon code to the url if provided',
        () async {
      await remoteDataSourceImpl.confirmOrder(
        tCart,
        userLocation: tUserLocation,
        coupon: tCoupon,
      );

      verify(
        mockClient.post(
          BASE_URL + '/cart/' + "?user_location=$tUserLocation&coupon=$tCoupon",
          body: jsonEncode(body),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );
    });

    test('should not contain coupon if there is no code specified', () async {
      await remoteDataSourceImpl.confirmOrder(
        tCart,
        userLocation: tUserLocation,
      );

      verify(
        mockClient.post(
          BASE_URL + '/cart/' + "?user_location=$tUserLocation",
          body: jsonEncode(body),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );
    });

    test('should return a valid [Order] if status code 200', () async {
      final result = await remoteDataSourceImpl.confirmOrder(
        tCart,
        userLocation: tUserLocation,
      );

      expect(result, tOrder);
    });

    test('should throw a [SERVEREXCEPTION] if status code not 200', () async {
      when(
        mockClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (realInvocation) async => Response(fixture('confirm-order.json'), 401),
      );

      final result = remoteDataSourceImpl.confirmOrder;

      expect(
        () => result(tCart, userLocation: tUserLocation),
        throwsA(isA<ServerException>()),
      );
    });
  });
}
