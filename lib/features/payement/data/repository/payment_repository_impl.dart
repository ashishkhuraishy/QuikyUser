import 'package:quiky_user/core/error/exception.dart';
import 'package:quiky_user/core/platform/network_info.dart';
import 'package:quiky_user/features/payement/data/data_source/payment_local_data_source.dart';
import 'package:quiky_user/features/payement/data/data_source/payment_remote_data_source.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:quiky_user/features/payement/domain/Entity/payment_card.dart';
import 'package:quiky_user/features/payement/domain/repository/payment_repository.dart';

class PaymentRepositoryImpl extends PaymentRepository {
  final NetworkInfo networkInfo;
  final PaymentLocalDataSource localDataSource;
  final PaymentRemoteDataSource remoteDataSource;

  PaymentRepositoryImpl({
    this.networkInfo,
    this.localDataSource,
    this.remoteDataSource,
  });

  @override
  void addCard(PaymentCard card) {
    localDataSource.addCard(card);
  }

  @override
  List<PaymentCard> getCards() {
    return localDataSource.getCards();
  }

  @override
  Future<Either<Failure, bool>> getStatus({
    int orderId,
    String paymentId,
    PaymentType paymentType,
  }) async {
    if (!(await networkInfo.isConnected)) return Left(ConnectionFailure());

    try {
      final status = await remoteDataSource.getPaymentStatus(
        orderId,
        paymentId,
        paymentType,
      );
      return Right(status);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
