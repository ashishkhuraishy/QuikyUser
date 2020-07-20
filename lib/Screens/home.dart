import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quiky_user/Models/address/AddressModel.dart';
import 'package:quiky_user/theme/themedata.dart';
import 'package:quiky_user/widgets/HomeMegaButton.dart';
import 'package:quiky_user/widgets/DividerLight.dart';
import 'package:quiky_user/widgets/OptionCard.dart';
import 'package:quiky_user/widgets/StoreCard.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Box box = Hive.box('Address');

  AddressModel address;

  @override
  void initState() {
    address = box.getAt(0) as AddressModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double scWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset('assets/img/map-pointer.png'),
            ),
            Text(
              address.shortAddress,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
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
                    color: Colors.orangeAccent),
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
            DividerLight(scWidth: scWidth),
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
                        style: darkBold16,
                      )
                    ],
                  ),
                  Text(
                    "Explore sponsored partner brands",
                    style: grey14,
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
            DividerLight(scWidth: scWidth),
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
            DividerLight(scWidth: scWidth),
            Container(
              padding: EdgeInsets.all(10),
              width: scWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Popular Brands",
                    style: darkBold16,
                  ),
                  Text(
                    "Most ordered from around your locality",
                    style: grey14,
                  ),
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
            DividerLight(scWidth: scWidth),
            Container(
              padding: EdgeInsets.only(top:10,left:10,right:10),
              width: scWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Near by restaurants",
                    style: darkBold16,
                  ),
                  Text(
                    "Trending restaurants near you",
                    style: grey14,
                  ),
                ],
              ),
            ),
            ListView(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(left:10),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: <Widget>[
                StoreCard(
                  scWidth: scWidth+20,
                ),
                StoreCard(
                  scWidth: scWidth+20,
                ),
                StoreCard(
                  scWidth: scWidth+20,
                ),
                StoreCard(
                  scWidth: scWidth+20,
                ),
                StoreCard(
                  scWidth: scWidth+20,
                ),
                StoreCard(
                  scWidth: scWidth+20,
                ),
                StoreCard(
                  scWidth: scWidth+20,
                ),
              ],
            ),
            DividerLight(scWidth: scWidth),
          ],
        ),
      ),
    );
  }
}
