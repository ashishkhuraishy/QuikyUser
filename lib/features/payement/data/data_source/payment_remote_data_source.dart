import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../../../../Constants/Apikeys.dart';
import '../../../../core/error/exception.dart';

enum PaymentType { CARD, COD }

abstract class PaymentRemoteDataSource {
  Future<String> getRazorPayId(
    int orderId,
    PaymentType paymentType,
  );
}

class PaymentRemoteDataSourceImpl extends PaymentRemoteDataSource {
  final Client client;

  PaymentRemoteDataSourceImpl({this.client});

  @override
  Future<String> getRazorPayId(
    int orderId,
    PaymentType paymentType,
  ) async {
    String paymentUrl = BASE_URL + '/payment/?payment_type=';
    switch (paymentType) {
      case PaymentType.CARD:
        paymentUrl += 'CARD';
        break;
      case PaymentType.COD:
        paymentUrl += 'COD';
        break;
      default:
        paymentUrl += 'COD';
        break;
    }

    Map<String, dynamic> body = {
      "order_id": orderId,
    };

    print(paymentUrl);
    print(body);

    Response response = await client.post(
      paymentUrl,
      body: jsonEncode(body),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );

    if (response.statusCode == 200) {
      var respBody = jsonDecode(response.body);
      print(respBody['razorpay']['id']);
      return respBody["razorpay"]["id"].toString();
    }
    print(response.statusCode);
    print(response.body);

    throw ServerException();
  }
}
