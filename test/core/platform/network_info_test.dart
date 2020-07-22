import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quiky_user/core/platform/network_info.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  MockDataConnectionChecker mockDataConnectionChecker;
  NetworkInfoImpl networkInfoImpl;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockDataConnectionChecker);
  });

  test(
      'should forward NetworkInfo.isConnected to DataConnectionChecker.hasConnection',
      () {
    final tHasConnectionFuture = Future.value(true);

    when(networkInfoImpl.isConnected)
        .thenAnswer((realInvocation) => tHasConnectionFuture);

    final result = networkInfoImpl.isConnected;
    verify(mockDataConnectionChecker.hasConnection);
    expect(result, tHasConnectionFuture);
  });
}
