import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiky_user/core/Providers/CartProvider.dart';

class StoreDetails extends StatelessWidget {
  const StoreDetails({
    Key key,
    @required this.scWidth,
  }) : super(key: key);

  final double scWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: scWidth,
      padding: EdgeInsets.all(20),
      child: Consumer<CartProvider>(
        builder: (ctx, provider, _) {
          print("${provider.currentStoreId}");
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              // Image.asset(
              //   provider.cu,
              //   width: 50,
              // ),
              Container(
                padding: const EdgeInsets.only(left: 10.0),
                width: scWidth - 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("${provider.currentTitle}",
                        style: Theme.of(context).textTheme.headline6),
                    Text(
                      "${provider.currentStoreAddress.trim()}",
                      style: Theme.of(context).textTheme.subtitle1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
