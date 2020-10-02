import 'package:flutter/material.dart';
import 'package:quiky_user/theme/themedata.dart';

class OrderPlaced extends StatelessWidget {
  const OrderPlaced({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Image.asset("assets/img/Confirmed-bro.png", height: 200),
            Text(
              "Order Confirmed",
              style: Theme.of(context).textTheme.headline5,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            RaisedButton(onPressed: (){
              Navigator.popAndPushNamed(context, '/currentOrder');
            },
            child: Text("Goto Orders",style: whiteBold14,),)
        ],
      ),
          ),),
    );
  }
}
