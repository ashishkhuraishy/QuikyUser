import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:quiky_user/core/error/exception.dart';
import 'package:quiky_user/features/home/data/data_source/home_remote_data_source.dart';
import 'package:quiky_user/features/user/data/model/order_details_model.dart';
import 'package:quiky_user/features/user/data/model/user_model.dart';
import 'package:quiky_user/features/user/domain/entity/order_details.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> login({
    @required String username,
    @required String password,
  });

  Future<UserModel> signUp({
    @required String username,
    @required String name,
    @required String password,
  });

  Future<List<OrderDetails>> pastOrders({int userId, String token});
  Future<OrderDetails> orderStatus(int orderId, {String token});
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  final Client client;
  final _fireBaseMessaging = FirebaseMessaging();

  UserRemoteDataSourceImpl({this.client});

  @override
  Future<UserModel> login({String username, String password}) async {
    String _token = await _fireBaseMessaging.getToken();
    String platform = Platform.isAndroid ? "android" : "ios";
    final String url = BASE_URL +
        '/login/$username/$password/?user=customer&registration_id=$_token&device_type=$platform';
    Response response = await client.get(url);
    initMessaging();
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data);
    }
    print(response.statusCode);
    print(response);
    throw ServerException();
  }

  @override
  Future<UserModel> signUp(
      {String username, String name, String password}) async {
    String _token = await _fireBaseMessaging.getToken();
    String platform = Platform.isAndroid ? "android" : "ios";
    final String url = BASE_URL +
        '/signup/?customer=true&registration_id=$_token&type=$platform';
    Map body = {
      "username": username,
      "password": password,
      "email": "dummy@dummymail.com",
      "first_name": name,
      "last_name": ""
    };
    initMessaging();
    print("Url : $url");
    print("Body : $body");
    Response response = await client.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(body));
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data);
    }
    print(response.statusCode);
    print(response.body);
    throw ServerException();
  }

  @override
  Future<List<OrderDetails>> pastOrders({int userId, String token}) async {
    final String url = BASE_URL + '/order_list/?filter=past&user_id=$userId';
    Response response = await client.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: "Token $token",
      },
    );
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => OrderDetailsModel.fromJson(e)).toList();
    }
    print(response.statusCode);
    print(response);
    throw ServerException();
  }

  @override
  Future<OrderDetails> orderStatus(int orderId, {String token}) async {
    final String url = BASE_URL + '/order/get_delete_update/$orderId';
    Response response = await client.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: "Token $token",
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return OrderDetailsModel.fromJson(data);
    }
    print(response.statusCode);
    print(response);
    throw ServerException();
  }

  initMessaging() {
    _fireBaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print('on message $message');
    }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
    });
  }
}
