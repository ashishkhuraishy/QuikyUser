import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/Providers/AddressProvider.dart';
import '../core/Providers/HomeProvider.dart';
import '../theme/themedata.dart';
import '../widgets/HomeMegaButton.dart';
import '../widgets/OptionCard.dart';
import '../widgets/StoreCard.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({
    Key key,
    @required this.scWidth,
  }) : super(key: key);

  final double scWidth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).popAndPushNamed('/selectlocation');
          },
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: mapPionter,
              ),
              Consumer<AddressProvider>(
                builder: (ctx, val, widget) {
                  return Text(
                    "${val.currentAddress.shortAddress}",
                    textAlign: TextAlign.left,
                    // style: TextTheme().headline1,
                    overflow: TextOverflow.ellipsis,
                  );
                },
              )
            ],
          ),
        ),
        elevation: 1.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                HomeMegaButton(
                    scWidth: scWidth,
                    title: 'Restaurant',
                    image: 'assets/img/plate-of-food.png',
                    color: primary),
                HomeMegaButton(
                    scWidth: scWidth,
                    title: 'Grocery',
                    image: 'assets/img/plate-of-food.png',
                    color: Colors.brown),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                  constraints: BoxConstraints(
                    minWidth: scWidth,
                  ),
                  height: 110,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      OptionCard(title: "MILK", image: "assets/img/milk.png"),
                      OptionCard(title: "Fish", image: "assets/img/fish.png"),
                      OptionCard(
                          title: "Electronics",
                          image: "assets/img/Electronics.png"),
                      // OptionCard(
                      //     title: "Quiky Specials",
                      //     image: "assets/img/Quiky-Specials.png"),
                      OptionCard(
                          title: "Bulk Order",
                          image: "assets/img/bulk_order.png"),
                    ],
                  )),
            ),
            Divider(
              thickness: 8,
            ),
            Container(
              padding: EdgeInsets.only(
                left: 10,
                bottom: 10,
                top: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, bottom: 8),
                        child: Image.asset(
                          "assets/img/h.png",
                          width: 30,
                        ),
                      ),
                      Text(
                        "In the Spotlight!",
                        style: Theme.of(context).textTheme.headline5,
                      )
                    ],
                  ),
                  Text(
                    "Explore sponsored partner brands",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Container(
                    height: 260,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            StoreCard(
                              scWidth: scWidth,
                            ),
                            StoreCard(
                              scWidth: scWidth,
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            StoreCard(
                              scWidth: scWidth,
                            ),
                            StoreCard(
                              scWidth: scWidth,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(
              thickness: 8,
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              width: scWidth,
              height: 110,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  OptionCard(
                      title: "South Indian", image: "assets/img/milk.png"),
                  OptionCard(title: "Biriyani", image: "assets/img/fish.png"),
                  OptionCard(
                      title: "Chinese", image: "assets/img/Electronics.png"),
                  OptionCard(
                      title: "Burgers", image: "assets/img/Quiky-Specials.png"),
                  OptionCard(
                      title: "Bulk Order", image: "assets/img/bulk_order.png"),
                ],
              ),
            ),
            Divider(
              thickness: 8,
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: scWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Popular Brands",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text("Most ordered from around your locality",
                      style: Theme.of(context).textTheme.subtitle1),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              width: scWidth,
              height: 126,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  OptionCard(
                    title: "Mc Donald's",
                    image: "assets/img/mcdonalds.jpg",
                    secondTitle: "3 mins",
                  ),
                  OptionCard(
                    title: "Mc Donald's",
                    image: "assets/img/mcdonalds.jpg",
                    secondTitle: "3 mins",
                  ),
                  OptionCard(
                    title: "Mc Donald's",
                    image: "assets/img/mcdonalds.jpg",
                    secondTitle: "3 mins",
                  ),
                  OptionCard(
                    title: "Mc Donald's",
                    image: "assets/img/mcdonalds.jpg",
                    secondTitle: "3 mins",
                  ),
                  OptionCard(
                    title: "Mc Donald's",
                    image: "assets/img/mcdonalds.jpg",
                    secondTitle: "3 mins",
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 8,
            ),
            Container(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              width: scWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Near by restaurants",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    "Trending restaurants near you",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            ListView(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(left: 10),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: <Widget>[
                StoreCard(
                  scWidth: scWidth + 20,
                ),
                StoreCard(
                  scWidth: scWidth + 20,
                ),
                StoreCard(
                  scWidth: scWidth + 20,
                ),
                StoreCard(
                  scWidth: scWidth + 20,
                ),
                StoreCard(
                  scWidth: scWidth + 20,
                ),
                StoreCard(
                  scWidth: scWidth + 20,
                ),
                StoreCard(
                  scWidth: scWidth + 20,
                ),
              ],
            ),
            Divider(
              thickness: 8,
            ),
          ],
        ),
      ),
    );
  }
}
