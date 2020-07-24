import 'package:flutter/material.dart';

import '../theme/themedata.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    @required this.scWidth,
  }) : super(key: key);

  final double scWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, bottom: 15.0, right: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              child: Image.asset(
                "assets/img/Burger.jpeg",
                width: 90,
                height: 110,
                fit: BoxFit.fill,
              ) //FoodSafetyDot(),
              ),
          Container(
            constraints: BoxConstraints(
              maxWidth: scWidth - 120,
            ),
            height: 110,
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Arabian Paradise hotel edappally kerala india india  india",
                  style: Theme.of(context).textTheme.headline5,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
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
                Align(
                    alignment: Alignment.bottomRight,
                    child: CustomBorderedButton(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("Add"),
                          Icon(Icons.add, color: primary)
                        ],
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
