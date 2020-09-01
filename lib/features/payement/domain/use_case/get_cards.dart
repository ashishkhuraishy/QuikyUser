import 'package:quiky_user/features/payement/domain/Entity/payment_card.dart';
import 'package:quiky_user/features/payement/domain/repository/payment_repository.dart';

class GetCards {
  final PaymentRepository repository;

  GetCards({
    this.repository,
  });

  List<PaymentCard> call() {
    return repository.getCards();
  }
}
