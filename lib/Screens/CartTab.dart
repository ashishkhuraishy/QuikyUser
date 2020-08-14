import 'package:flutter/material.dart';
import 'package:quiky_user/theme/themedata.dart';
import 'package:quiky_user/widgets/ProductCard.dart';

class CartTab extends StatelessWidget {
  const CartTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double scWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StoreDetails(),
            ListView(
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: <Widget>[
                ProductCard(scWidth: scWidth, addedToCart: true),
                ProductCard(scWidth: scWidth, addedToCart: true),
                ProductCard(scWidth: scWidth, addedToCart: true),
              ],
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                
                children: <Widget>[
                  Text(
                      "Apply Coupon",
                      style: whiteBold13,
                    ),
                  FlatButton(
                    color: primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Apply",
                      style: whiteBold13,
                    ),
                  ),
                ],
              )
            ),
            NoContactDeliveryCard(),
          ],
        ),
      ),
    ));
  }
}

class NoContactDeliveryCard extends StatelessWidget {
  const NoContactDeliveryCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: primary),
          borderRadius: BorderRadius.circular(5),
          color: primary10Fade),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.check_circle_outline),
              Text(
                "  No Contact Delivery",
                style: Theme.of(context).textTheme.headline6,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Our Delivery Partner will call to confirm. Please Make payment through online for selecting No Contact Delivery.",
            style: Theme.of(context).textTheme.bodyText1,
          )
        ],
      ),
    );
  }
}

class StoreDetails extends StatelessWidget {
  const StoreDetails({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            "assets/img/Burger.jpeg",
            width: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Paragon Rstaurant",
                    style: Theme.of(context).textTheme.headline6),
                Text("Edappally", style: Theme.of(context).textTheme.subtitle1),
              ],
            ),
          )
        ],
      ),
    );
  }
}
