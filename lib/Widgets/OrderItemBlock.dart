import 'package:flutter/material.dart';

import '../Screens/CartTab.dart';
import '../features/user/domain/entity/order_details.dart';
import '../theme/themedata.dart';
import 'FoodSafetyDot.dart';

class OrderItemBlock extends StatelessWidget {
  const OrderItemBlock({
    Key key,
    @required this.scWidth,
    @required this.orderdetails,
  }) : super(key: key);

  final OrderDetails orderdetails;
  final double scWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // color: Theme.of(context).
          border: Border.all(color: primary),
        ),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: orderdetails.order.status != "delivered" &&
                        orderdetails.order.status != "abonded"
                    ? 0
                    : 13,
                left: 10,
                right: 10,
                bottom: orderdetails.order.status != "delivered" &&
                        orderdetails.order.status != "abonded"
                    ? 0
                    : 10,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(9),
                    topRight: Radius.circular(9),
                  ),
                  color: primary),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order Id: ${orderdetails.order.id}",
                  ),
                  orderdetails.order.status != "delivered" &&
                          orderdetails.order.status != "abonded"
                      ? ButtonTheme(
                          minWidth: 10,
                          height: 12,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/trackOrder',
                                arguments: orderdetails,
                              );
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: Colors.red,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Text("Track", style: white13),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
            Divider(
              height: 1,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: orderdetails.order.items.length,
                    itemBuilder: (ctx1, index1) {
                      return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FoodSafetyDot(color: Colors.green),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${orderdetails.order.items[index1].name}",
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                    Text(
                                      "₹${orderdetails.order.items[index1].price}",
                                      style: primaryBold14,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Divider(),
                          ],
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Store: ${orderdetails.storeName}',
                    ),
                  ),
                  PaymentRow(
                      title: "Status",
                      price: "${orderdetails.order.status}",
                      style: Theme.of(context).textTheme.subtitle1),
                  PaymentRow(
                      title: "Payment Method",
                      price:
                          "${orderdetails.order.paymentType != 'nill' ? orderdetails.order.paymentType : 'POD'}",
                      style: Theme.of(context).textTheme.subtitle1),
                  PaymentRow(
                      title: "Sub Total",
                      price: "₹${orderdetails.order.subTotal}",
                      style: Theme.of(context).textTheme.subtitle1),
                  PaymentRow(
                      title: "Delivery & other Fee",
                      price: "₹${orderdetails.order.delCharges}",
                      style: Theme.of(context).textTheme.subtitle1),
                  PaymentRow(
                      title: "Tax",
                      price: "₹${orderdetails.order.taxtotal}",
                      style: Theme.of(context).textTheme.subtitle1),
                  PaymentRow(
                      title: "Total",
                      price: "₹${orderdetails.order.total}",
                      style: Theme.of(context).textTheme.headline5)
                ],
              ),
            ),
          ],
        ));
  }
}
