import 'package:flutter/material.dart';
import 'package:quiky_user/Screens/CartTab.dart';
import 'package:quiky_user/Widgets/FoodSafetyDot.dart';
import 'package:quiky_user/Widgets/ProductCard.dart';
import 'package:quiky_user/features/cart/domain/entity/order.dart';
import 'package:quiky_user/features/user/domain/entity/order_details.dart';
import 'package:quiky_user/theme/themedata.dart';

class OrderItemBlock extends StatelessWidget {
  const OrderItemBlock({
    Key key,
    @required this.scWidth,
    @required this.orders,
  }) : super(key: key);

  final OrderDetails orders;
  final double scWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: Theme.of(context).
            border: Border.all(color: primary)),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: orders.status != "delivered" && orders.status != "abonded" ?0:13,
                left: 10,
                right: 10,
                bottom:  orders.status != "delivered" && orders.status != "abonded" ?0:10,
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
                    "Order Id: ${orders.orderId}",
                  ),
                  orders.status != "delivered" && orders.status != "abonded"
                      ? ButtonTheme(
                          minWidth: 10,
                          height: 12,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/trackOrder',arguments: orders);
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
                    itemCount: orders.cart.cartItems.length,
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
                                      "${orders.cart.cartItems[index1].name}",
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                    Text(
                                      "₹${orders.cart.cartItems[index1].price}",
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
                      'Store: ${orders.storeName}',
                    ),
                  ),
                  PaymentRow(
                      title: "Status",
                      price: "${orders.status}",
                      style: Theme.of(context).textTheme.subtitle1),
                  PaymentRow(
                      title: "Payment Method",
                      price:
                          "${orders.paymentType != 'nill' ? orders.paymentType : 'POD'}",
                      style: Theme.of(context).textTheme.subtitle1),
                  PaymentRow(
                      title: "Sub Total",
                      price: "₹${orders.subTotal}",
                      style: Theme.of(context).textTheme.subtitle1),
                  PaymentRow(
                      title: "Delivery & other Fee",
                      price: "₹${orders.deliveryIncentative}",
                      style: Theme.of(context).textTheme.subtitle1),
                  PaymentRow(
                      title: "Tax",
                      price: "₹${orders.taxTotal}",
                      style: Theme.of(context).textTheme.subtitle1),
                  PaymentRow(
                      title: "Total",
                      price: "₹${orders.total}",
                      style: Theme.of(context).textTheme.headline5)
                ],
              ),
            ),
          ],
        ));
  }
}
