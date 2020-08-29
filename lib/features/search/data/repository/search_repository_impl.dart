import 'package:quiky_user/core/platform/network_info.dart';
import 'package:quiky_user/features/home/domain/entity/restaurents.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:quiky_user/features/search/data/data_source/search_local_data.dart';
import 'package:quiky_user/features/search/data/data_source/search_remote_data_source.dart';
import 'package:quiky_user/features/search/domain/repository/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final NetworkInfo networkInfo;
  final SearchLocalDataSource localDataSource;
  final SearchRemoteDataSource remoteDataSource;

  SearchRepositoryImpl({
    this.networkInfo,
    this.localDataSource,
    this.remoteDataSource,
  });

  @override
  List<String> getQueries() {
    return localDataSource.getCache().reversed.toList();
  }

  @override
  Future<Either<Failure, List<Restaurant>>> getResult(
      {String query, double lat, double lng}) async {
    if (!(await networkInfo.isConnected)) return Left(ConnectionFailure());
    List<Restaurant> result = [];

    try {
      result = await remoteDataSource.getResults(query, lat, lng);
    } catch (e) {
      return Left(ServerFailure());
    }

    final lru = localDataSource.getCache();
    if (lru.contains(query)) lru.remove(query);
    lru.add(query);
    if (lru.length > 3) lru.removeAt(0);
    localDataSource.newList(lru);

    return Right(result);
  }
}
