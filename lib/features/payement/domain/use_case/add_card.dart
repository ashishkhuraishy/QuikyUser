import 'package:quiky_user/features/payement/domain/Entity/payment_card.dart';
import 'package:quiky_user/features/payement/domain/repository/payment_repository.dart';

class AddCard {
  final PaymentRepository repository;

  AddCard({
    this.repository,
  });

  void call({PaymentCard card}) {
    return repository.addCard(card);
  }
}
