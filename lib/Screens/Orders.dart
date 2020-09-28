import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiky_user/Widgets/OrderItemBlock.dart';
import 'package:quiky_user/core/Providers/UserProvider.dart';
import 'package:quiky_user/features/user/domain/entity/order_details.dart';

class Orders extends StatelessWidget {
  const Orders({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders", style: Theme.of(context).textTheme.headline5),
      ),
      body: FutureBuilder(
        future:
            Provider.of<UserProvider>(context, listen: false).getPastOrders(),
        builder: (ctx, AsyncSnapshot<List<OrderDetails>> orders) {
          if (orders.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (orders.hasError) {
            print(orders.error.toString());
            return Center(child: Text("Internal Error"));
          } else if (orders.hasData) {
            List<OrderDetails> ordersR = orders.data.reversed.toList();
            return ListView.builder(
              itemCount: ordersR.length,
              itemBuilder: (ctxx, index) {
                return OrderItemBlock(
                  scWidth: MediaQuery.of(context).size.width,
                  orderdetails: ordersR[index],
                );
              },
            );
          } else {
            print(orders.error.toString());
            return Center(child: Text("No data"));
          }
        },
      ),
    );
  }
}
