import 'package:quiky_user/Constants/Apikeys.dart';
import 'package:quiky_user/features/cart/domain/entity/order.dart';
import 'package:quiky_user/features/payement/data/data_source/payment_remote_data_source.dart';
import 'package:quiky_user/features/payement/domain/use_case/get_payment_status.dart';
import 'package:quiky_user/features/user/domain/entity/user.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../injection_container.dart';

class PaymentService {
  Razorpay _razorpay;
  GetRazorPayId _getRazorPayId = GetRazorPayId(repository: sl());

  PaymentService() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  Future startOnlinePayment({Order order, User user, String storeName}) async {
    final result = await _getRazorPayId.call(
      orderId: order.id,
      paymentType: PaymentType.CARD,
    );

    int total = (double.tryParse(order.total) * 100).floor();

    result.fold(
      (failure) => print(failure.runtimeType),
      (razorpayId) {
        Map options = {
          'key': '$RAZOR_PAY_KEY',
          'amount': total, //in the smallest currency sub-unit.
          'name': '$storeName',
          'order_id': '$razorpayId', // Generate order_id using Orders API
          // 'description': '${}',
          'timeout': 60, // in seconds
          'prefill': {
            'contact': '${user.mobile}',
          },
        };
        _razorpay.open(options);
      },
    );
  }

  Future startCod(Order order) async {
    final result = await _getRazorPayId.call(
      orderId: order.id,
      paymentType: PaymentType.COD,
    );

    result.fold(
      (failure) => print("Failure : $failure"),
      (razorPayId) => print("Sucess : order sucessfull"),
    );
  }

  // Call this at Dispose
  void clearinstance() => _razorpay.clear();

  // helper Methods
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Sucess ${response.orderId}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Failed : ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('Moved To external Wallet : ${response.walletName}');
  }
}
