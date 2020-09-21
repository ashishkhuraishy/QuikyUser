import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:quiky_user/core/error/exception.dart';
import 'package:quiky_user/features/home/data/data_source/home_remote_data_source.dart';

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

    Response response = await client.post(
      paymentUrl,
      body: jsonEncode(body),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );

    if (response.statusCode == 200) {
      Map respBody = jsonDecode(response.body);
      print(respBody.toString());
      return respBody["razorpay"]["id"];
    }

    throw ServerException();
  }
}
