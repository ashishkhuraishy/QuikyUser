import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:quiky_user/features/user/data/model/user_model.dart';
import 'package:quiky_user/features/user/domain/entity/user.dart';

import '../../../../fixtures/fixture_reader.dart';

main() {
  final userName = 'Paragon@123';
  final email = 'catering@paragonrestaurant.net';
  final name = 'Paragon';
  final mobile = '0484 4011000';

  final userModel = UserModel(
    id: 27,
    userId: 15,
    userName: userName,
    name: name,
    token: '2cc636e0581003877b1f1370334f8628c858d104',
    email: email,
    mobile: mobile,
  );

  test('should be subType of User', () {
    expect(userModel, isA<User>());
  });

  test('should return a valid UserModel from the json', () {
    final data = jsonDecode(fixture('user-login.json'));

    final result = UserModel.fromJson(data);
    expect(result, userModel);
  });
}
