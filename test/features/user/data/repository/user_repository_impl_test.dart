import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quiky_user/core/error/exception.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/user/data/datasource/user_local_data_source.dart';
import 'package:quiky_user/features/user/data/datasource/user_remote_data_source.dart';
import 'package:quiky_user/features/user/data/model/user_model.dart';
import 'package:quiky_user/features/user/data/repository/user_repository_impl.dart';
import 'package:quiky_user/features/user/domain/repository/user_repository.dart';

import '../../../location_service/data/repository/address_repository_impl_test.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockUserLocalDataSource extends Mock implements UserLocalDataSource {}

class MockUserRemoteDataSource extends Mock implements UserRemoteDataSource {}

main() {
  MockNetworkInfo networkInfo;
  MockUserLocalDataSource mockLocalDataSource;
  MockUserRemoteDataSource mockRemoteDataSource;

  UserRepositoryImpl repositoryImpl;

  setUp(() {
    networkInfo = MockNetworkInfo();
    mockLocalDataSource = MockUserLocalDataSource();
    mockRemoteDataSource = MockUserRemoteDataSource();

    repositoryImpl = UserRepositoryImpl(
      networkInfo: networkInfo,
      localDataSource: mockLocalDataSource,
      remoteDataSource: mockRemoteDataSource,
    );
  });

  final userName = 'hello';
  final password = '123';
  final email = 'test@testmail.com';
  final name = 'Hello World';
  final mobile = '9876543210';

  final userModel = UserModel(
    id: 4,
    userId: 87,
    userName: userName,
    name: name,
    token: 'hgwefsdfghksdfghsdfsdfjhsdfjhdfsdfsdff',
    email: email,
    mobile: mobile,
  );

  group('LogIn', () {
    test('should return [ConnectionFailure] if not active connection',
        () async {
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);

      final result = await repositoryImpl.login(
        username: userName,
        password: password,
      );

      expect(result, Left(ConnectionFailure()));
    });

    group('and connected', () {
      setUp(() {
        when(networkInfo.isConnected)
            .thenAnswer((realInvocation) async => true);
      });

      test('should return a valid User from remote', () async {
        when(mockRemoteDataSource.login(
                username: anyNamed('username'), password: anyNamed('password')))
            .thenAnswer(
          (realInvocation) async => userModel,
        );

        final result = await repositoryImpl.login(
          username: userName,
          password: password,
        );
        verify(
          mockRemoteDataSource.login(username: userName, password: password),
        );
        verify(mockLocalDataSource.cacheUser(userModel));
        expect(result, Right(userModel));
      });
      test('should return a ServerFailure on any Exception', () async {
        when(mockRemoteDataSource.login(
                username: anyNamed('username'), password: anyNamed('password')))
            .thenThrow(ServerException());

        final result = await repositoryImpl.login(
          username: userName,
          password: password,
        );
        verify(
          mockRemoteDataSource.login(username: userName, password: password),
        );
        expect(result, Left(ServerFailure()));
      });
    });
  });

  group('SignUp', () {
    test('should return [ConnectionFailure] if not active connection',
        () async {
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);

      final result = await repositoryImpl.signUp(
        username: userName,
        password: password,
        email: email,
        name: name,
        phoneNo: mobile,
      );

      expect(result, Left(ConnectionFailure()));
    });

    group('and connected', () {
      setUp(() {
        when(networkInfo.isConnected)
            .thenAnswer((realInvocation) async => true);
      });

      test('should return a valid User from remote', () async {
        when(
          mockRemoteDataSource.signUp(
            username: anyNamed('username'),
            password: anyNamed('password'),
            email: anyNamed('email'),
            name: anyNamed('name'),
            phoneNo: anyNamed('phoneNo'),
          ),
        ).thenAnswer(
          (realInvocation) async => userModel,
        );

        final result = await repositoryImpl.signUp(
          username: userName,
          password: password,
          email: email,
          name: name,
          phoneNo: mobile,
        );
        verify(
          mockRemoteDataSource.signUp(
            username: userName,
            password: password,
            email: email,
            name: name,
            phoneNo: mobile,
          ),
        );
        verify(mockLocalDataSource.cacheUser(userModel));
        expect(result, Right(userModel));
      });
      test('should return a ServerFailure on any Exception', () async {
        when(mockRemoteDataSource.signUp(
          username: anyNamed('username'),
          password: anyNamed('password'),
          email: anyNamed('email'),
          name: anyNamed('name'),
          phoneNo: anyNamed('phoneNo'),
        )).thenThrow(ServerException());

        final result = await repositoryImpl.signUp(
          username: userName,
          password: password,
          email: email,
          name: name,
          phoneNo: mobile,
        );
        verify(
          mockRemoteDataSource.signUp(
            username: userName,
            password: password,
            email: email,
            name: name,
            phoneNo: mobile,
          ),
        );
        expect(result, Left(ServerFailure()));
      });
    });
  });

  group('logOut', () {
    test('should call the logout method', () {
      repositoryImpl.logout();
      verify(mockLocalDataSource.logout());
    });
  });
}
