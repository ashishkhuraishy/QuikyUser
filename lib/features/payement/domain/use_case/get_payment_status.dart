import 'package:dartz/dartz.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/payement/data/data_source/payment_remote_data_source.dart';
import 'package:quiky_user/features/payement/domain/repository/payment_repository.dart';

class GetPaymentStatus {
  final PaymentRepository repository;

  GetPaymentStatus({
    this.repository,
  });

  Future<Either<Failure, bool>> call({
    int orderId,
    String paymentId,
    PaymentType paymentType,
  }) {
    return repository.getStatus(
      orderId: orderId,
      paymentId: paymentId,
      paymentType: paymentType,
    );
  }
}
