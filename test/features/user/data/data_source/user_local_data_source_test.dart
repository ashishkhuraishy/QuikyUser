import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quiky_user/features/user/data/datasource/user_local_data_source.dart';
import 'package:quiky_user/features/user/data/model/user_model.dart';

import '../../../location_service/data/data_source/address_local_data_source_test.dart';

main() {
  MockHive mockHive;
  MockHiveBox mockHiveBox;
  UserLocalDataSourceImpl localDataSourceImpl;

  setUp(() {
    mockHive = MockHive();
    mockHiveBox = MockHiveBox();
    localDataSourceImpl = UserLocalDataSourceImpl(hive: mockHive);
  });

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

  group('Cache User', () {
    setUp(() {
      when(mockHive.isBoxOpen(any)).thenAnswer((realInvocation) => true);
      when(mockHive.box(any)).thenReturn(mockHiveBox);
    });
    test('should open the box if not open', () {
      localDataSourceImpl.cacheUser(userModel);
      verify(mockHive.isBoxOpen(CORE_BOX));
    });

    test('should open the COREBOX box if closed', () async {
      when(mockHive.isBoxOpen(any)).thenAnswer((realInvocation) => false);
      await localDataSourceImpl.cacheUser(userModel);
      verify(mockHive.isBoxOpen(CORE_BOX));
      verify(mockHive.openBox(CORE_BOX));
    });

    test('should put the UserModel data on the box', () async {
      when(mockHive.box(any)).thenReturn(mockHiveBox);

      await localDataSourceImpl.cacheUser(userModel);
      verify(mockHive.box(CORE_BOX));
      verify(mockHiveBox.put(USER, userModel));
    });
  });

  group('Log Out', () {
    setUp(() {
      when(mockHive.isBoxOpen(any)).thenAnswer((realInvocation) => true);
      when(mockHive.box(any)).thenReturn(mockHiveBox);
    });
    test('should open the box if not open', () {
      localDataSourceImpl.logout();
      verify(mockHive.isBoxOpen(CORE_BOX));
    });

    test('should open the COREBOX box if closed', () async {
      when(mockHive.isBoxOpen(any)).thenAnswer((realInvocation) => false);
      await localDataSourceImpl.logout();
      verify(mockHive.isBoxOpen(CORE_BOX));
      verify(mockHive.openBox(CORE_BOX));
    });

    test('should put the USER as [null] data on the box', () async {
      when(mockHive.box(any)).thenReturn(mockHiveBox);

      await localDataSourceImpl.logout();
      verify(mockHive.box(CORE_BOX));
      verify(mockHiveBox.put(USER, null));
    });
  });
}
