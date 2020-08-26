import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:quiky_user/core/error/exception.dart';
import 'package:quiky_user/features/home/data/data_source/home_remote_data_source.dart';
import 'package:quiky_user/features/user/data/datasource/user_remote_data_source.dart';
import 'package:quiky_user/features/user/data/model/user_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockClient extends Mock implements Client {}

main() {
  MockClient mockClient;
  UserRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockClient = MockClient();
    remoteDataSourceImpl = UserRemoteDataSourceImpl(client: mockClient);
  });

  final userName = 'Paragon@123';
  final password = '123';
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

  group('Signup', () {
    setUp(() {
      when(mockClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer(
        (realInvocation) async =>
            Response(fixture('user-login.json'), HttpStatus.created),
      );
    });

    final String url = BASE_URL + '/signup/?customer=true';

    Map body = {
      "username": userName,
      "password": password,
      "email": "dummy@dummymail.com",
      "first_name": name,
      "last_name": ""
    };

    test('should call the post method', () async {
      await remoteDataSourceImpl.signUp(
          name: name, password: password, username: userName);

      verify(
        mockClient.post(
          url,
          headers: {HttpHeaders.contentTypeHeader: "application/json"},
          body: jsonEncode(body),
        ),
      );
    });

    test('should return [UserModel] if status created', () async {
      final result = await remoteDataSourceImpl.signUp(
          name: name, password: password, username: userName);

      verify(mockClient.post(url,
          headers: {HttpHeaders.contentTypeHeader: "application/json"},
          body: jsonEncode(body)));
      expect(result, userModel);
    });

    test('should return [ServerFailure] if any failure occurs', () async {
      when(
        mockClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenThrow(ServerException());
      final result = remoteDataSourceImpl.signUp;

      expect(() => result(name: name, password: password, username: userName),
          throwsA(isA<ServerException>()));
    });
  });

  group('Login', () {
    setUp(() {
      when(mockClient.get(any)).thenAnswer(
        (realInvocation) async =>
            Response(fixture('user-login.json'), HttpStatus.ok),
      );

      final url = BASE_URL + '/login/$userName/$password/?user=customer';

      test('should call the get method', () async {
        await remoteDataSourceImpl.login(
            password: password, username: userName);

        verify(mockClient.get(url));
      });

      test('should return [UserModel] if status created', () async {
        final result = await remoteDataSourceImpl.login(
            password: password, username: userName);

        verify(mockClient.get(url));
        expect(result, userModel);
      });

      test('should return [ServerFailure] if any failure occurs', () async {
        when(mockClient.get(any)).thenThrow(ServerException());
        final result = remoteDataSourceImpl.login;

        expect(() => result(password: password, username: userName),
            throwsA(isA<ServerException>()));
      });
    });
  });
}
