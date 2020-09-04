import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:quiky_user/core/error/exception.dart';
import 'package:quiky_user/features/cart/data/model/order_model.dart';
import 'package:quiky_user/features/cart/domain/entity/cart.dart';
import 'package:quiky_user/features/cart/domain/entity/order.dart';
import 'package:quiky_user/features/home/data/data_source/home_remote_data_source.dart';

abstract class CartRemoteDataSource {
  Future<Order> confirmOrder(
    Cart cart, {
    String token,
    String userLocation,
    String shippingAddress,
    String coupon,
    DateTime dateTime,
  });
}

class CartRemoteDataSourceImpl extends CartRemoteDataSource {
  final Client client;

  CartRemoteDataSourceImpl({this.client});

  @override
  Future<Order> confirmOrder(
    Cart cart, {
    String token,
    String userLocation,
    String shippingAddress,
    String coupon,
    DateTime dateTime,
  }) async {
    String url = BASE_URL + '/cart/';

    List<Map<String, dynamic>> variations = [];
    cart.cartItems.forEach((element) {
      Map<String, dynamic> variation = {
        "variation": "${element.id}",
        "quantity": "${element.quantity}",
      };

      variations.add(variation);
    });
    // TODO : Editi these to implement Bulk & Milk Order
    Map<String, dynamic> body = {
      "store_id": "${cart.storeId}",
      "cart_item": variations,
      "shipping_address": shippingAddress,
      "bulk_order": "false",
      "milk_order": "false",
      "date_time": "${dateTime ?? DateTime.now().toLocal()}",
    };

    url += "?user_location=$userLocation";
    if (coupon != null) url += "&coupon=$coupon";

    Response response = await client.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Token $token",
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> reponseBody = jsonDecode(response.body);
      return OrderModel.fromJson(reponseBody);
    }
    print(response.statusCode);
    print(response.body);

    throw ServerException();
  }
}
