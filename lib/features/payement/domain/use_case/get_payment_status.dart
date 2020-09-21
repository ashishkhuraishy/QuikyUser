import 'package:dartz/dartz.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/payement/data/data_source/payment_remote_data_source.dart';
import 'package:quiky_user/features/payement/domain/repository/payment_repository.dart';

class GetRazorPayId {
  final PaymentRepository repository;

  GetRazorPayId({
    this.repository,
  });

  Future<Either<Failure, String>> call({
    int orderId,
    PaymentType paymentType,
  }) {
    return repository.getRazorPayId(
      orderId: orderId,
    );
  }
}
