import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:quiky_user/features/search/data/data_source/search_local_data.dart';
import 'package:quiky_user/features/user/data/datasource/user_local_data_source.dart';

class MockHive extends Mock implements HiveInterface {}

class MockBox extends Mock implements Box {}

main() {
  MockHive mockHive = MockHive();
  MockBox mockBox = MockBox();
  SearchLocalDataSourceImpl localDataSourceImpl =
      SearchLocalDataSourceImpl(hive: mockHive);

  List<String> tList = ["Test 1", "Test 2", "Test 3"];

  setUp(() {
    when(mockHive.isBoxOpen(any)).thenAnswer((realInvocation) => true);
    when(mockHive.box(any)).thenAnswer((realInvocation) => mockBox);
    when(mockBox.get(any, defaultValue: anyNamed('defaultValue')))
        .thenAnswer((realInvocation) => tList);
  });

  group('Get Cache', () {
    test('should open the box if it is closed', () {
      when(mockHive.isBoxOpen(any)).thenAnswer((realInvocation) => false);

      localDataSourceImpl.getCache();
      verify(mockHive.openBox(CORE_BOX));
    });

    test('should return an empty list if box is empty', () {
      when(mockBox.get(any, defaultValue: anyNamed('defaultValue')))
          .thenAnswer((realInvocation) => null);

      final result = localDataSourceImpl.getCache();
      verify(mockBox.get(LRU, defaultValue: []));
      expect(result, []);
    });

    test('should return an list of string when called', () {
      final result = localDataSourceImpl.getCache();
      verify(mockBox.get(LRU, defaultValue: []));
      expect(result, tList);
    });
  });

  group('Add To List', () {
    test('should open the box if it is closed', () {
      when(mockHive.isBoxOpen(any)).thenAnswer((realInvocation) => false);

      localDataSourceImpl.newList(tList);
      verify(mockHive.openBox(CORE_BOX));
    });

    test('should put the `newList into the box`', () {
      localDataSourceImpl.newList(tList);
      verify(mockBox.put(LRU, tList));
    });
  });
}
