import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:quiky_user/features/cart/data/model/cart_model.dart';
import 'package:quiky_user/features/cart/domain/entity/cart.dart';
import 'package:quiky_user/features/user/data/datasource/user_local_data_source.dart';

const String CART = "CART";

abstract class CartLocalDataSource {
  Future<Cart> getCart();
  Future<bool> saveCart(Cart cart);
}

class CartLocalDataSourceImpl extends CartLocalDataSource {
  final HiveInterface hive;

  CartLocalDataSourceImpl({
    @required this.hive,
  });

  @override
  Future<Cart> getCart() async {
    if (!hive.isBoxOpen(CORE_BOX)) hive.openBox(CORE_BOX);
    return await hive.box(CORE_BOX).get(
          CART,
          defaultValue: Cart(
            storeId: -1,
            cartItems: [],
            offers: [],
          ),
        );
  }

  @override
  Future<bool> saveCart(Cart cart) async {
    if (!hive.isBoxOpen(CORE_BOX)) hive.openBox(CORE_BOX);
    Box box = hive.box(CORE_BOX);
    await box.put(CART, cart);
    return true;
  }
}
