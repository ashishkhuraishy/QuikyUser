import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quiky_user/features/cart/data/data_sources/cart_local_data_source.dart';
import 'package:quiky_user/features/cart/data/repository/cart_repository_impl.dart';
import 'package:quiky_user/features/cart/domain/repository/cart_repository.dart';

import 'core/platform/location_info.dart';
import 'core/platform/network_info.dart';
import 'features/home/data/data_source/home_remote_data_source.dart';
import 'features/home/data/repository/home_repository_impl.dart';
import 'features/home/domain/repository/home_repository.dart';
import 'features/location_service/data/data_source/address_local_data_sourc.dart';
import 'features/location_service/data/data_source/address_remote_data_source.dart';
import 'features/location_service/data/model/address_model.dart';
import 'features/location_service/data/repository/address_repository_imp.dart';
import 'features/location_service/domain/repository/address_repo.dart';
import 'features/location_service/domain/usecase/cache_address.dart';
import 'features/location_service/domain/usecase/get_address.dart';
import 'features/products/data/data_source/product_remote_data_source.dart';
import 'features/products/data/repository/product_repository_impl.dart';
import 'features/products/domain/repository/products_repository.dart';
import 'features/user/data/datasource/user_local_data_source.dart';
import 'features/user/data/datasource/user_remote_data_source.dart';
import 'features/user/data/model/user_model.dart';
import 'features/user/data/repository/user_repository_impl.dart';
import 'features/user/domain/repository/user_repository.dart';

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

  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(
      localDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AddressRemoteDataSource>(
    () => AddressRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<AddressLocalDataSource>(
    () => AddresLocalDataSourceImpl(
      hive: sl(),
    ),
  );

  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<ProductsRemoteDataSource>(
    () => ProductsRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(
      hive: sl(),
    ),
  );

  sl.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(
      hive: sl(),
    ),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<LocationInfo>(
    () => LocationInfoImpl(
      location: sl(),
    ),
  );

  //! External
  final hive = Hive;
  sl.registerLazySingleton(() => hive);
  sl.registerLazySingleton(() => Client());
  sl.registerLazySingleton(() => Location());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
