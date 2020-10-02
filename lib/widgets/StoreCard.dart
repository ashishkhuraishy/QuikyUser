import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Constants/Apikeys.dart';
import '../features/home/data/model/restaurant_model.dart';
import '../theme/themedata.dart';

class StoreCard extends StatelessWidget {
  const StoreCard({
    Key key,
    @required this.scWidth,
    @required this.restaurantModel,
  }) : super(key: key);

  final double scWidth;
  final RestaurantModel restaurantModel;

  static String api = BASE_URL;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/store', arguments: restaurantModel);
        // Navigator.push(context,CupertinoPageRoute(builder: (context) => Store(),settings: RouteSettings(arguments: restaurantModel)));

        //ModalRoute.of(context).settings.arguments;
      },
      child: Container(
        margin: EdgeInsets.only(
          right: 10,
          bottom: 10,
          top: 10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              overflow: Overflow.visible,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  child: Image.network(
                    "$api${restaurantModel.profilePicture}",
                    width: 90,
                    height: 90,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned.fill(
                  bottom: -6,
                  child: restaurantModel.offers.length > 0
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                                color: primary,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Text(
                              "${restaurantModel.offers[0].percentage}% OFF",
                              style: whiteBold13,
                            ),
                          ),
                        )
                      : Container(),
                )
              ],
            ),
            Container(
              constraints: BoxConstraints(
                  maxWidth: scWidth - 130, minWidth: scWidth - 130),
              height: 90,
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${restaurantModel.title} ",
                        style: Theme.of(context).textTheme.headline5,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                  Text(
                    "${restaurantModel.storeSubType!='nill'?restaurantModel.storeSubType:''}",
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${restaurantModel.location}",
                    // "${restaurantModel.address}",
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis,
                  ),
                    ],
                  ),
                  // Spacer(flex:8),
                  Text(
                    "★ ${restaurantModel.avgRating!='nill'?restaurantModel.avgRating:0} • ${int.tryParse(restaurantModel.avgDeliveryTime) != null ? int.tryParse(restaurantModel.avgDeliveryTime) + 25 : 25} mins • ₹${restaurantModel.minimumCostTwo} for two",
                    style: Theme.of(context).textTheme.bodyText1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
