import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:quiky_user/core/error/exception.dart';
import 'package:quiky_user/features/home/data/data_source/home_remote_data_source.dart';
import 'package:quiky_user/features/user/data/model/user_model.dart';

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
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  final Client client;

  UserRemoteDataSourceImpl({this.client});

  @override
  Future<UserModel> login({String username, String password}) async {
    final String url = BASE_URL + '/login/$username/$password/?user=customer';
    Response response = await client.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data);
    }
    throw ServerException();
  }

  @override
  Future<UserModel> signUp(
      {String username, String name, String password}) async {
    final String url = BASE_URL + '/signup/?customer=true';
    Map body = {
      "username": username,
      "password": password,
      "email": "dummy@dummymail.com",
      "first_name": name,
      "last_name": "1"
    };

    Response response = await client.post(url, headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        }, body: jsonEncode(body));
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data);
    }
    print("Deeeeeeeeeeeeebug");
    print(body);
    print(response.statusCode);
    print(response.body);
    print("Deeeeeeeeeeeeebug --------------- END");

    throw ServerException();
  }
}
