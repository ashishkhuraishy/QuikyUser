import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:quiky_user/features/cart/domain/entity/cart_item.dart';
import 'package:quiky_user/features/home/domain/entity/offer.dart';

part 'cart.g.dart';

@HiveType(typeId: 14)
class Cart extends Equatable {
  @HiveField(0)
  final int storeId;
  @HiveField(3)
  final String storeName;
  @HiveField(4)
  final String storeAddress;
  @HiveField(5)
  final String storeImage;
  @HiveField(6)
  final String storeLogo;
  @HiveField(1)
  final List<Offer> offers;
  @HiveField(2)
  final List<CartItem> cartItems;

  Cart({
    @required this.storeId,
    @required this.offers,
    @required this.cartItems,
    @required this.storeName,
    @required this.storeAddress,
    @required this.storeImage,
    @required this.storeLogo,
  });

  @override
  List<Object> get props => [
        storeId,
        storeName,
        storeAddress,
        offers,
        cartItems,
        storeImage,
        storeLogo,
      ];

  double get total {
    double result = 0.0;
    cartItems.forEach((element) {
      result += element.inlineTotal;
    });

    return result;
  }
}
