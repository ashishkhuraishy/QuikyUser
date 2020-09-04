import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:quiky_user/Constants/Apikeys.dart';
import 'package:quiky_user/features/payement/data/data_source/payment_remote_data_source.dart';
import 'package:quiky_user/features/payement/domain/Entity/payment_card.dart';
import 'package:quiky_user/features/payement/domain/Entity/stripe_transaction_response.dart';
import 'package:quiky_user/features/payement/domain/use_case/add_card.dart';
import 'package:quiky_user/features/payement/domain/use_case/get_cards.dart';
import 'package:quiky_user/features/payement/domain/use_case/get_payment_status.dart';
import 'package:stripe_payment/stripe_payment.dart';

import '../../injection_container.dart';

class StripeService {
  // Initialising UseCases
  GetPaymentStatus _getPaymentStatus = GetPaymentStatus(repository: sl());
  AddCard _addCard = AddCard(repository: sl());
  GetCards _getCards = GetCards(repository: sl());

  // Getter method to get all cards
  List<PaymentCard> get cards => _getCards();

  // Initialising Stripe
  StripeService() {
    StripePayment.setOptions(
      StripeOptions(
          publishableKey: "$STRIPE_PUB_KEY",
          merchantId: "Test",
          androidPayMode: 'test'),
    );
  }

  // initialising Urls and headers
  String paymentApiUrl = '$STRIPE_BASE/payment_intents';
  Map<String, String> headers = {
    'Authorization': 'Bearer $STRIPE_SEC_KEY',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  // Public Classes

  // PayWithExisting Card
  Future<StripeTransactionResponse> payViaExistingCard({
    int orderId,
    String amount,
    String currency,
    PaymentCard card,
  }) async {
    StripeTransactionResponse transactionResponse = StripeTransactionResponse();
    print('Pay with existing card called');
    int amnt = num.parse(amount).toInt() * 100;
    try {
      var paymentMethod = await StripePayment.createPaymentMethod(
          PaymentMethodRequest(card: card.toCreditCard()));
      var paymentIntent = await _createPaymentIntent(amnt.toString(), currency);
      print(paymentIntent['id']);
      transactionResponse =
          await _confirmPayment(paymentMethod, paymentIntent, orderId);
    } on PlatformException catch (err) {
      return _getPlatformExceptionErrorResult(err);
    } catch (err) {
      transactionResponse = StripeTransactionResponse(
          message: 'Transaction failed: ${err.toString()}', success: false);
    }
    print(transactionResponse.message);
    print(transactionResponse.success);
    return transactionResponse;
  }

  // Save and Pay with a new Card
  Future<StripeTransactionResponse> payWithNewCard({
    int orderId,
    String amount,
    String currency,
  }) async {
    StripeTransactionResponse transactionResponse = StripeTransactionResponse();

    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest(),
      );
      _addCard(card: PaymentCard.fromCreditCard(paymentMethod.card));
      var paymentIntent = await _createPaymentIntent(amount, currency);
      transactionResponse =
          await _confirmPayment(paymentMethod, paymentIntent, orderId);
      return transactionResponse;
    } on PlatformException catch (err) {
      return _getPlatformExceptionErrorResult(err);
    } catch (err) {
      transactionResponse = StripeTransactionResponse(
          message: 'Transaction failed: ${err.toString()}', success: false);
    }
    return transactionResponse;
  }

  // Helper Methods

  _getPlatformExceptionErrorResult(err) {
    String message = 'Something went wrong';
    if (err.code == 'cancelled') {
      message = 'Transaction cancelled';
    }

    return new StripeTransactionResponse(message: message, success: false);
  }

  Future<Map<String, dynamic>> _createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response =
          await http.post(paymentApiUrl, body: body, headers: headers);
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
    return null;
  }

  Future<StripeTransactionResponse> _confirmPayment(PaymentMethod paymentMethod,
      Map<String, dynamic> paymentIntent, int orderId) async {
    StripeTransactionResponse transactionResponse;

    var response = await StripePayment.confirmPaymentIntent(
      PaymentIntent(
        clientSecret: paymentIntent['client_secret'],
        paymentMethodId: paymentMethod.id,
      ),
    );

    print(paymentIntent['id']);
    print(paymentMethod.id);
    print(paymentMethod.customerId);
    final result = await _getPaymentStatus(
      orderId: orderId,
      paymentId: paymentIntent['id'],
      paymentType: PaymentType.CARD,
    );

    print("Result : ${result}");

    result.fold((failure) {
      print("Error Occured at $failure");

      // if failure occurs we will take the response provided by package

      if (response.status == 'succeeded') {
        transactionResponse = StripeTransactionResponse(
            message: 'Transaction successful', success: true);
      } else {
        transactionResponse = StripeTransactionResponse(
            message: 'Transaction failed', success: false);
      }
    }, (status) {
      if (status == true) {
        transactionResponse = StripeTransactionResponse(
            message: 'Transaction successful', success: true);
      }
      print("Response Status :  ${response.status}");
      transactionResponse = StripeTransactionResponse(
          message: 'Transaction failed', success: false);
    });

    if (response.status == 'succeeded') {
      transactionResponse = StripeTransactionResponse(
          message: 'Transaction successful', success: true);
    } else {
      transactionResponse = StripeTransactionResponse(
          message: 'Transaction failed', success: false);
    }

    return transactionResponse;
  }
}
