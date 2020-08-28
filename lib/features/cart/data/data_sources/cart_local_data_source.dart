import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:quiky_user/core/error/exception.dart';

import '../../../user/data/datasource/user_local_data_source.dart';
import '../../domain/entity/cart.dart';

const String CART = "CART";
const String ORDER_ID = "ORDER_ID";

abstract class CartLocalDataSource {
  Future<Cart> getCart();
  Future<bool> saveCart(Cart cart);
  void setOrderId(int id);
  String getToken();
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
            storeName: "",
            storeAddress: "",
            storeImage: "",
            storeLogo: "",
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

  @override
  void setOrderId(int id) {
    if (!hive.isBoxOpen(CORE_BOX)) hive.openBox(CORE_BOX);
    Box box = hive.box(CORE_BOX);
    box.put(ORDER_ID, id);
  }

  @override
  String getToken() {
    if (!hive.isBoxOpen(CORE_BOX)) hive.openBox(CORE_BOX);
    Box box = hive.box(CORE_BOX);
    String res = box.get(USER);
    if (res != null || res.length < 1) return res;
    throw UserException();
  }
}
