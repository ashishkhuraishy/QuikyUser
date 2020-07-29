import 'package:flutter/material.dart';

import '../theme/themedata.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    @required this.scWidth,
    this.addedToCart,
  }) : super(key: key);

  final double scWidth;
  final bool addedToCart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, bottom: 15.0, right: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
<<<<<<< HEAD
              child: Image.asset(
                "assets/img/Burger.jpeg",
                width: 90,
                height: 110,
                fit: BoxFit.fill,
              ) //FoodSafetyDot(),
=======
              child: Stack(
                children: <Widget>[
                    Image.asset(
                    "assets/img/Burger.jpeg",
                    width: 90,
                    height: 112,
                    fit: BoxFit.cover,
                  ),
                  // Container(
                  //   width: 30,
                  //   height: 30,
                  // ),
                  Positioned(top: 0, right: 0, child: FoodSafetyDot())
                ],
              ) //,
>>>>>>> 49f70a62e59534fa2b2da06a2d76cf76e9b4e931
              ),
          Container(
            constraints: BoxConstraints(
              maxWidth: scWidth - 120,
              // maxWidth: scWidth - 70,
            ),
            height: 112,
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Arabian Paradise hotel edappally kerala india india  india",
                  style: Theme.of(context).textTheme.headline5,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                // Spacer(flex:1),
                Text(
                  "Arabian, South indian",
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "₹45",
                  style: primaryBold14,
                  overflow: TextOverflow.ellipsis,
                ),
<<<<<<< HEAD
                Align(
                    alignment: Alignment.bottomRight,
                    child: CustomBorderedButton(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("Add"),
                          Icon(Icons.add, color: primary)
                        ],
=======
                addedToCart != null && addedToCart
                    ? Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: primary)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(
                                width: 40,
                                height: 30,
                                child: FlatButton(
                                  padding: EdgeInsets.all(2),
                                  onPressed: () {},
                                  child: Icon(Icons.remove, color: primary),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text("1"),
                              ),
                              SizedBox(
                                width: 40,
                                height: 30,
                                child: FlatButton(
                                  padding: EdgeInsets.all(2),
                                  onPressed: () {},
                                  child: Icon(Icons.add, color: primary),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Align(
                        alignment: Alignment.bottomRight,
                        child: CustomBorderedButton(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text("Add"),
                              Icon(Icons.add, color: primary)
                            ],
                          ),
                        ),
>>>>>>> 49f70a62e59534fa2b2da06a2d76cf76e9b4e931
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
