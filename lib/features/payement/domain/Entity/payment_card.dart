import 'package:hive/hive.dart';
import 'package:stripe_payment/stripe_payment.dart';

part 'payment_card.g.dart';

@HiveType(typeId: 17)
class PaymentCard {
  @HiveField(0)
  String addressCity;
  @HiveField(2)
  String addressCountry;
  @HiveField(3)
  String addressLine1;
  @HiveField(4)
  String addressLine2;
  @HiveField(5)
  String addressState;
  @HiveField(6)
  String addressZip;
  @HiveField(7)
  String brand;
  @HiveField(8)
  String cardId;
  @HiveField(9)
  String country;
  @HiveField(10)
  int expMonth;
  @HiveField(11)
  int expYear;
  @HiveField(12)
  String funding;
  @HiveField(13)
  String last4;
  @HiveField(14)
  String name;
  @HiveField(15)
  String number;
  @HiveField(16)
  String cvc;
  @HiveField(17)
  String token;

  PaymentCard({
    this.addressCity,
    this.addressCountry,
    this.addressLine1,
    this.addressLine2,
    this.addressState,
    this.addressZip,
    this.brand,
    this.cardId,
    this.country,
    this.expMonth,
    this.expYear,
    this.number,
    this.token,
    this.cvc,
    this.funding,
    this.last4,
    this.name,
  });

  factory PaymentCard.fromCreditCard(CreditCard creditCard) {
    return PaymentCard(
      addressCity: creditCard.addressCity,
      addressCountry: creditCard.addressCountry,
      addressLine1: creditCard.addressLine1,
      addressLine2: creditCard.addressLine2,
      addressState: creditCard.addressState,
      addressZip: creditCard.addressZip,
      brand: creditCard.brand,
      cardId: creditCard.cardId,
      country: creditCard.country,
      cvc: creditCard.cvc,
      expMonth: creditCard.expMonth,
      expYear: creditCard.expYear,
      funding: creditCard.funding,
      last4: creditCard.last4,
      name: creditCard.name,
      number: creditCard.number,
      token: creditCard.token,
    );
  }

  CreditCard toCreditCard() {
    return CreditCard(
      addressCity: this.addressCity,
      addressCountry: this.addressCountry,
      addressLine1: this.addressLine1,
      addressLine2: this.addressLine2,
      addressState: this.addressState,
      addressZip: this.addressZip,
      brand: this.brand,
      cardId: this.cardId,
      country: this.country,
      cvc: this.cvc,
      expMonth: this.expMonth,
      expYear: this.expYear,
      funding: this.funding,
      last4: this.last4,
      name: this.name,
      number: this.number,
      token: this.token,
    );
  }
}
