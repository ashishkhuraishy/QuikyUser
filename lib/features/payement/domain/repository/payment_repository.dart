import 'package:dartz/dartz.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/payement/data/data_source/payment_remote_data_source.dart';
import 'package:quiky_user/features/payement/domain/Entity/payment_card.dart';

abstract class PaymentRepository {
  List<PaymentCard> getCards();
  void addCard(PaymentCard card);

  Future<Either<Failure, String>> getRazorPayId({
    int orderId,
    PaymentType paymentType,
  });
}
