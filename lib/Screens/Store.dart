import 'package:flutter/material.dart';
import 'package:quiky_user/theme/themedata.dart';
import 'package:quiky_user/widgets/ProductCard.dart';
import 'package:quiky_user/widgets/RatingStar.dart';

class Store extends StatelessWidget {
  const Store({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double scWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // persistentFooterButtons: <Widget>[Text("asdsad")],
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () {},
              color: Colors.redAccent,
              child: Text("Menu", style: whiteBold13),
            ),
            Container(
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              width: scWidth - 30,
              decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("1 item", style: white13),
                      Row(
                        children: <Widget>[
                          Text("₹45 ", style: whiteBold13),
                          Text("plus taxes", style: white13),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "View Cart ►",
                        style: whiteBold13,
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        appBar: AppBar(
          actions: <Widget>[
            Spacer(
              flex: 20,
            ),
            Icon(Icons.info_outline),
            Spacer(
              flex: 1,
            ),
            Icon(Icons.search),
            Spacer(
              flex: 1,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        "Hotel Saravana Bhavan perumbavoor eranakulam kerala india ",
                        style: Theme.of(context).textTheme.headline5,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3),
                    RatingStarIdicator(),
                    Text("South Indian, Kerala, North Indian, Chinease ",
                        style: Theme.of(context).textTheme.bodyText1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              Divider(
                height: 2,
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        mapPionter,
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              "Delivering to Home (A28, Green Acres, Ayyapankavu, Kochi)",
                              style: Theme.of(context).textTheme.bodyText1,
                              maxLines: 3,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ),
                        CustomBorderedButton(
                          onTap: () {},
                          child: Text(
                            "Change",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Divider(
                height: 2,
              ),
              Container(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("₹30 Distance fee applicable", style: primary13),
                    Row(
                      children: <Widget>[
                        Icon(Icons.fastfood, size: 20, color: success),
                        Spacer(
                          flex: 1,
                        ),
                        Text(
                          "Pure Veg",
                          style: success13,
                        ),
                        Switch(
                          value: false,
                          onChanged: (val) {},
                          activeColor: success,
                          inactiveThumbColor: grey,
                          inactiveTrackColor: Colors.black12,
                        ),
                        Spacer(
                          flex: 20,
                        ),
                        Icon(Icons.search)
                      ],
                    ),
                  ],
                ),
              ),
              ExpansionTileProducts(scWidth: scWidth),
              ExpansionTileProducts(scWidth: scWidth),
              ExpansionTileProducts(scWidth: scWidth),
              ExpansionTileProducts(scWidth: scWidth),
              ExpansionTileProducts(scWidth: scWidth),
              ExpansionTileProducts(scWidth: scWidth),
              ExpansionTileProducts(scWidth: scWidth),
              ExpansionTileProducts(scWidth: scWidth),
              ExpansionTileProducts(scWidth: scWidth),
              Container(
                width: scWidth,
                height: 105,
              ),
            ],
          ),
        ));
  }
}

class ExpansionTileProducts extends StatelessWidget {
  const ExpansionTileProducts({
    Key key,
    @required this.scWidth,
  }) : super(key: key);

  final double scWidth;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text("Idili", style: Theme.of(context).textTheme.headline5, overflow: TextOverflow.ellipsis),
      subtitle: Text(
          "5 items, idili, vada ididli, vada, dosa, idili, vada dosa idili, vada dosa",
          style: Theme.of(context).textTheme.subtitle1,
          overflow: TextOverflow.ellipsis),
      children: <Widget>[
        ProductCard(scWidth: scWidth),
        ProductCard(scWidth: scWidth),
        ProductCard(scWidth: scWidth),
      ],
    );
  }
}
