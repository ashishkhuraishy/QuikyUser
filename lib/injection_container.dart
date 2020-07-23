import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';

import 'core/platform/location_info.dart';
import 'core/platform/network_info.dart';
import 'features/location_service/data/data_source/address_local_data_sourc.dart';
import 'features/location_service/data/data_source/address_remote_data_source.dart';
import 'features/location_service/data/repository/address_repository_imp.dart';
import 'features/location_service/domain/repository/address_repo.dart';
import 'features/location_service/domain/usecase/cache_address.dart';
import 'features/location_service/domain/usecase/get_address.dart';

final sl = GetIt.instance;
Future<void> init() async {
  // Use cases
  sl.registerLazySingleton(() => GetAddress(sl()));
  sl.registerLazySingleton(() => CacheAddress(repo: sl()));

  // Repository
  sl.registerLazySingleton<AddressRepository>(
    () => AddressRepositoryImpl(
      localDataSource: sl(),
      networkInfo: sl(),
      remoteDataSource: sl(),
      locationInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AddressRemoteDataSource>(
    () => AddressRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<AddressLocalDataSource>(
    () => AddresLocalDataSourceImpl(hive: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<LocationInfo>(
      () => LocationInfoImpl(location: sl()));

  //! External
  final hive = Hive;
  sl.registerLazySingleton(() => hive);
  sl.registerLazySingleton(() => Client());
  sl.registerLazySingleton(() => Location());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
