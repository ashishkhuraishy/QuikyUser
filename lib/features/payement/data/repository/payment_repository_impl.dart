import 'package:quiky_user/core/error/exception.dart';
import 'package:quiky_user/core/platform/network_info.dart';
import 'package:quiky_user/features/payement/data/data_source/payment_remote_data_source.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:quiky_user/features/payement/domain/repository/payment_repository.dart';

class PaymentRepositoryImpl extends PaymentRepository {
  final NetworkInfo networkInfo;
  final PaymentRemoteDataSource remoteDataSource;

  PaymentRepositoryImpl({
    this.networkInfo,
    this.remoteDataSource,
  });

  @override
  Future<Either<Failure, String>> getRazorPayId({
    int orderId,
    PaymentType paymentType,
  }) async {
    if (!(await networkInfo.isConnected)) return Left(ConnectionFailure());

    try {
      final razorPayId = await remoteDataSource.getRazorPayId(
        orderId,
        paymentType,
      );
      return Right(razorPayId);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
