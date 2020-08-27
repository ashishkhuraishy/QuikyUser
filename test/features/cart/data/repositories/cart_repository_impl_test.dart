import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quiky_user/core/error/exception.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/cart/data/data_sources/cart_local_data_source.dart';
import 'package:quiky_user/features/cart/data/data_sources/cart_remote_data_source.dart';
import 'package:quiky_user/features/cart/data/model/order_model.dart';
import 'package:quiky_user/features/cart/data/repository/cart_repository_impl.dart';
import 'package:quiky_user/features/cart/domain/entity/cart.dart';
import 'package:quiky_user/features/cart/domain/entity/cart_item.dart';
import 'package:quiky_user/features/home/domain/entity/offer.dart';
import 'package:quiky_user/features/home/domain/entity/restaurents.dart';
import 'package:quiky_user/features/products/domain/entity/variation.dart';

import '../../../location_service/data/repository/address_repository_impl_test.dart';

class MockCartLocalDataSource extends Mock implements CartLocalDataSource {}

class MockRemoteDataSource extends Mock implements CartRemoteDataSource {}

MockCartLocalDataSource mockCartLocalDataSource;
MockRemoteDataSource remoteDataSource;
MockNetworkInfo networkInfo;
CartRepositoryImpl repositoryImpl;

main() {
  mockCartLocalDataSource = MockCartLocalDataSource();
  remoteDataSource = MockRemoteDataSource();
  networkInfo = MockNetworkInfo();
  repositoryImpl = CartRepositoryImpl(
    localDataSource: mockCartLocalDataSource,
    remoteDataSource: remoteDataSource,
    networkInfo: networkInfo,
  );

  final tUserLocation = "10.789,89.255";
  final tCoupon = "quicky50";

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
    id: 5,
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
  final tNewQuantity = 9;
  final tSToreId = 3;
  final tStoreName = "Test Store";
  final tStoreAddress = "Test Address";
  final tStorelogo = "Test logo";
  final tImage = "Test Image";
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

  final tRestaurant = Restaurant(
    id: tSToreId,
    offers: tOffers,
    employeeId: null,
    title: tStoreName,
    mobile: null,
    gst: null,
    tinTan: null,
    typeGoods: null,
    delivery: null,
    vendor: null,
    customer: null,
    popularBrand: null,
    brandLogo: tStorelogo,
    profilePicture: tImage,
    fssai: null,
    storeSubType: null,
    status: null,
    option: null,
    totalReviews: null,
    avgRating: null,
    coordinate: null,
    address: tStoreAddress,
    recommendationCount: null,
    minimumCostTwo: null,
    avgDeliveryTime: null,
    active: null,
    inOrder: null,
    bulkOrder: null,
    opening: null,
    closing: null,
    highlightStatus: null,
    featuredBrand: null,
    commisionPercentage: null,
    user: null,
    city: null,
    zone: null,
    vendorLocation: null,
  );

  final tCartItem = CartItem(
    id: tVariation.id,
    name: tVariation.title,
    price: tVariation.price,
    inStock: tVariation.isStock,
    quantity: tQuantity,
  );

  final tAddedCartItem = CartItem(
    id: tVariation.id,
    name: tVariation.title,
    price: tVariation.price,
    inStock: tVariation.isStock,
    quantity: tNewQuantity,
  );

  final tCart = Cart(
    storeId: tSToreId,
    offers: tOffers,
    storeImage: tImage,
    storeAddress: tStoreAddress,
    storeLogo: tStorelogo,
    storeName: tStoreName,
    cartItems: [
      tCartItem,
    ],
  );

  final tAddedCart = Cart(
    storeId: tSToreId,
    offers: tOffers,
    storeImage: tImage,
    storeLogo: tStorelogo,
    storeAddress: tStoreAddress,
    storeName: tStoreName,
    cartItems: [
      tAddedCartItem,
    ],
  );

  final tRemovedItemCart = Cart(
    storeId: tSToreId,
    offers: tOffers,
    storeImage: tImage,
    storeLogo: tStorelogo,
    storeAddress: tStoreAddress,
    storeName: tStoreName,
    cartItems: [],
  );

  final tEmptyCart = Cart(
    storeId: -1,
    storeAddress: "",
    storeName: "",
    storeImage: "",
    storeLogo: "",
    offers: [],
    cartItems: [],
  );

  final tOrder = OrderModel(
    id: 80,
    items: [
      tCartItem,
      tCartItem,
    ],
    total: "184.00",
    subTotal: "80.00",
    delCharges: "100.00",
    taxtotal: "4.00",
    discountAmount: "0.00",
    coupon: "nill",
  );

  group('Add Item', () {
    test('should create and save a new [CART] when the `storeId` dont match',
        () async {
      when(mockCartLocalDataSource.getCart())
          .thenAnswer((realInvocation) async => tEmptyCart);

      final result = await repositoryImpl.addItem(
        variation: tVariation,
        quantity: tQuantity,
        restaurant: tRestaurant,
      );

      verify(mockCartLocalDataSource.saveCart(tCart));
      expect(result.storeId, 3);
    });

    test('should remove a [CARTITEM] if the `quantity` is 0', () async {
      when(mockCartLocalDataSource.getCart())
          .thenAnswer((realInvocation) async => tCart);
      final result = await repositoryImpl.addItem(
        variation: tVariation,
        quantity: 0,
        restaurant: tRestaurant,
      );

      verify(mockCartLocalDataSource.saveCart(tRemovedItemCart));
      expect(result.cartItems.length, 0);
    });

    test('should increase the quantity if element already in the [CART]',
        () async {
      when(mockCartLocalDataSource.getCart())
          .thenAnswer((realInvocation) async => tCart);

      final result = await repositoryImpl.addItem(
        variation: tVariation,
        quantity: tNewQuantity,
        restaurant: tRestaurant,
      );

      verify(mockCartLocalDataSource.saveCart(tAddedCart));
      expect(result.cartItems[0].quantity, tNewQuantity);
    });

    test(
        'should add the [VARIATION] as [CARTITEM] into [CART] if having same `storeId`',
        () async {
      when(mockCartLocalDataSource.getCart()).thenAnswer(
        (realInvocation) async => tCart,
      );

      final result = await repositoryImpl.addItem(
        variation: tVariation2,
        quantity: tQuantity,
        restaurant: tRestaurant,
      );

      verify(mockCartLocalDataSource.saveCart(tCart));
      expect(result.cartItems.length, 2);
    });
  });

  group('Get Cart', () {
    test('should return a valid [CART]', () async {
      when(mockCartLocalDataSource.getCart()).thenAnswer(
        (realInvocation) async => tCart,
      );
      final result = await repositoryImpl.getCart();

      verify(mockCartLocalDataSource.getCart());
      expect(result, tCart);
    });
  });

  group('Clear Cart', () {
    test('should add an Empty [CART]', () {
      repositoryImpl.clear();

      verify(mockCartLocalDataSource.saveCart(tEmptyCart));
    });
  });

  group('Confirm Order', () {
    setUp(() {
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
      when(mockCartLocalDataSource.getCart()).thenAnswer(
        (realInvocation) async => tCart,
      );
      when(
        remoteDataSource.confirmOrder(
          any,
          userLocation: anyNamed('userLocation'),
          coupon: anyNamed('coupon'),
        ),
      ).thenAnswer(
        (realInvocation) async => tOrder,
      );
    });

    test('should return [CONNECTION FAILURE] if not connected', () async {
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);

      final result =
          await repositoryImpl.confirmorder(userlocation: tUserLocation);

      verify(networkInfo.isConnected);
      expect(result, Left(ConnectionFailure()));
    });

    test('should get the cart from local and use that to call remote api',
        () async {
      final result = await repositoryImpl.confirmorder(
          userlocation: tUserLocation, coupon: tCoupon);

      verify(mockCartLocalDataSource.getCart());
      verify(
        remoteDataSource.confirmOrder(
          tCart,
          userLocation: tUserLocation,
          coupon: tCoupon,
        ),
      );
      verify(mockCartLocalDataSource.setOrderId(tOrder.id));
      expect(result, Right(tOrder));
    });

    test('should return a [SERVER FAILURE] on [SERVER EXCEPTION]', () async {
      when(
        remoteDataSource.confirmOrder(
          any,
          userLocation: anyNamed('userLocation'),
          coupon: anyNamed('coupon'),
        ),
      ).thenThrow(ServerException());

      final result = await repositoryImpl.confirmorder(
        userlocation: tUserLocation,
      );

      verify(mockCartLocalDataSource.getCart());
      verify(
        remoteDataSource.confirmOrder(
          tCart,
          userLocation: tUserLocation,
          coupon: null,
        ),
      );
      verifyNever(mockCartLocalDataSource.setOrderId(tOrder.id));
      expect(result, Left(ServerFailure()));
    });
  });
}
