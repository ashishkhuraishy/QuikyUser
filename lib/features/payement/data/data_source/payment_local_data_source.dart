import 'package:hive/hive.dart';
import 'package:quiky_user/features/payement/domain/Entity/payment_card.dart';

const String CARDS_BOX = "CARDS_BOX";

abstract class PaymentLocalDataSource {
  List<PaymentCard> getCards();
  void addCard(PaymentCard card);
}

class PaymentLocalDataSourceImpl extends PaymentLocalDataSource {
  final HiveInterface hive;

  PaymentLocalDataSourceImpl({this.hive});

  @override
  void addCard(PaymentCard card) {
    if (!hive.isBoxOpen(CARDS_BOX)) hive.openBox(CARDS_BOX);
    Hive.box(CARDS_BOX).add(card);
  }

  @override
  List<PaymentCard> getCards() {
    if (!hive.isBoxOpen(CARDS_BOX)) hive.openBox(CARDS_BOX);
    List<PaymentCard> cards = [];

    Hive.box(CARDS_BOX).toMap().forEach((key, value) {
      cards.add(value as PaymentCard);
    });

    return cards;
  }
}
