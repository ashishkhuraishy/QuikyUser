import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quiky_user/core/Providers/CartProvider.dart';
import 'package:quiky_user/core/Services/payment-service.dart';
import 'package:quiky_user/features/cart/domain/entity/order.dart';
import 'package:quiky_user/features/payement/data/data_source/payment_local_data_source.dart';
import 'package:quiky_user/features/payement/domain/Entity/payment_card.dart';
import 'package:quiky_user/theme/themedata.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ExistingCardsPage extends StatefulWidget {
  ExistingCardsPage({Key key}) : super(key: key);

  @override
  ExistingCardsPageState createState() => ExistingCardsPageState();
}

class ExistingCardsPageState extends State<ExistingCardsPage> {
  StripeService stripeService = StripeService();

  List<PaymentCard> cards = [
    // {
    //   'cardNumber': '4242424242424242',
    //   'expiryDate': '04/24',
    //   'cardHolderName': 'Muhammad Ahsan Ayaz',
    //   'cvvCode': '424',
    //   'showBackView': false,
    // },
    // {
    //   'cardNumber': '4000002500003155',
    //   'expiryDate': '04/23',
    //   'cardHolderName': 'Tracer',
    //   'cvvCode': '123',
    //   'showBackView': false,
    // }
  ];

  void displayCardBottomSheet(BuildContext context) {
    final key = GlobalKey<FormState>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return BottomSheet(
          onClosing: () {},
          builder: (context1) {
            return Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: StatefulBuilder(
                builder: (ctxx, val) {
                  return SingleChildScrollView(
                    child: Container(
                        padding: EdgeInsets.only(bottom: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Form(
                                  key: key,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        textAlign: TextAlign.left,
                                        maxLines: 1,
                                        validator: (value) => value.isEmpty
                                            ? 'Required'
                                            : null,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                        decoration: underlined(
                                            hint: "Card Holder Name"),
                                      ),
                                      TextFormField(
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.left,
                                        maxLines: 1,
                                        validator: (value) => value.isEmpty
                                            ? 'Required'
                                            : null,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                        decoration:
                                            underlined(hint: "Card Number:"),
                                      ),
                                      TextFormField(
                                        keyboardType: TextInputType.number,
                                          maxLines: 1,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        validator: (value) => value.isEmpty
                                            ? 'Required'
                                            : null,
                                        onChanged: (val){
                                          setState(() {
                                          val="13";
                                            
                                          });
                                        },
                                          decoration:
                                              underlined(hint: "Exp Date:")),
                                      TextFormField(
                                        keyboardType: TextInputType.number,
                                          maxLines: 1,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        validator: (value) => value.isEmpty
                                            ? 'Required'
                                            : null,
                                          decoration: underlined(hint: "CVV:")),
                                    ],
                                  ),
                                )),
                            Container(
                              height: 50,
                              child: FlatButton(
                                onPressed: () {
                                  if (key.currentState.validate()) {
                                    key.currentState.save();
                                    Navigator.pop(context);
                                  }
                                },
                                colorBrightness: Brightness.dark,
                                color: primary,
                                child: Text(
                                  "Continue",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        )),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  payViaExistingCard(BuildContext context, card, Order order) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    var expiryArr = card['expiryDate'].split('/');
    CreditCard stripeCard = CreditCard(
      number: card['cardNumber'],
      expMonth: int.parse(expiryArr[0]),
      expYear: int.parse(expiryArr[1]),
    );
    // print("Aaaaaaaaaaaa ${order.id}");
    var response = await stripeService.payViaExistingCard(
      amount: order.total,
      currency: 'INR',
      card: PaymentCard.fromCreditCard(stripeCard),
      orderId: order.id,
    );
    await dialog.hide();

    if (response.success) {
      Provider.of<CartProvider>(context, listen: false).clear;
    }

    Scaffold.of(context)
        .showSnackBar(SnackBar(
          content: Text(response.message),
          duration: new Duration(milliseconds: 1200),
        ))
        .closed
        .then((_) {
      Navigator.pop(context);
    });
  }

  void payWithNewCard(order) async {
    var response = await stripeService.payWithNewCard(
        orderId: order.id,
        amount: (double.tryParse(order.total) * 10).toString(),
        currency: 'INR');

    if (response.success) {
      Provider.of<CartProvider>(context, listen: false).clear;
      // Navigator.pop(context);
      // Navigator.pop(context);
    }

    Scaffold.of(context)
        .showSnackBar(SnackBar(
          content: Text(response.message),
          duration: new Duration(milliseconds: 1200),
        ))
        .closed
        .then((_) {
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Order order = ModalRoute.of(context).settings.arguments;
    Box cardsBox = Hive.box(CARDS_BOX);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Choose existing card',
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.headline5,
        ),
        actions: [
          InkWell(
            onTap: () async {
              // print(order.total);
              // payWithNewCard(order);
              displayCardBottomSheet(context);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: ValueListenableBuilder<Box>(
          valueListenable: cardsBox.listenable(),
          builder: (ctx, Box data, _) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                // var card = cards[index];
                if (data.length > -1) {
                  return InkWell(
                    onTap: () {
                      payViaExistingCard(context, data.getAt(index), order);
                    },
                    onLongPress: () {
                      data.deleteAt(index);
                    },
                    child: CreditCardWidget(
                      cardNumber: '123',
                      expiryDate:
                          "${data.getAt(index).expMonth}/${data.getAt(index).expYear}",
                      cardHolderName: "123",
                      cvvCode: "123",
                      showBackView: false,
                      cardBgColor: primary,
                    ),
                  );
                } else {
                  return Center(child: Text("No Card Saved"));
                }
              },
            );
          },
        ),
      ),
    );
  }
}
