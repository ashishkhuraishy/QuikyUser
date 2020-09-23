import 'package:dartz/dartz.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/payement/data/data_source/payment_remote_data_source.dart';

abstract class PaymentRepository {
  Future<Either<Failure, String>> getRazorPayId({
    int orderId,
    PaymentType paymentType,
  });
}
