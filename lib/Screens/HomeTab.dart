import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiky_user/features/location_service/domain/entity/address.dart';

import '../core/Providers/AddressProvider.dart';
import '../core/Providers/HomeProvider.dart';
import '../features/home/data/data_source/home_remote_data_source.dart';
import '../theme/themedata.dart';
import '../widgets/HomeMegaButton.dart';
import '../widgets/OptionCard.dart';
import '../widgets/StoreCard.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({
    Key key,
    @required this.scWidth,
  }) : super(key: key);

  final double scWidth;

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  // }

  /// TODO : Commented out unused varibles and [INIT] state
  /// [DELETE] if not using them

  @override
  void initState() {
    super.initState();
    final currentAddress =
        Provider.of<AddressProvider>(context, listen: false).currentAddress;

    final getData = Provider.of<HomeProvider>(context, listen: false)
        .getData(currentAddress.lat, currentAddress.long);
  }

  // void fetchData(Address currectAddress){
  //   final getData = Provider.of<HomeProvider>(context,listen:false).getData(currectAddress.lat, currectAddress.long);
  // }

  @override
  Widget build(BuildContext context) {
    // final currentAddress =  Provider.of<AddressProvider>(context,listen: false).currentAddress;
    // final getData = Provider.of<HomeProvider>(context,listen:false).getData(currentAddress.lat, currentAddress.long);
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            final address = Provider.of<AddressProvider>(context, listen: false)
                .currentAddress;
            print(address);
            // Navigator.of(context).popAndPushNamed('/selectlocation');
          },
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: mapPionter,
              ),
              Consumer<AddressProvider>(
                builder: (ctx, val, widget) {
                  // fetchData(val.currentAddress);
                  return Text(
                    "${val.currentAddress.shortAddress}",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline5,
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                HomeMegaButton(
                    scWidth: widget.scWidth,
                    title: 'Restaurant',
                    image: 'assets/img/plate-of-food.png',
                    color: primary),
                HomeMegaButton(
                    scWidth: widget.scWidth,
                    title: 'Grocery',
                    image: 'assets/img/plate-of-food.png',
                    color: Colors.brown),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                  constraints: BoxConstraints(
                    minWidth: widget.scWidth,
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
              thickness: 2,
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
                  Consumer<HomeProvider>(
                    builder: (ctx, provider, _) {
                      return Container(
                        height: provider.inTheSpotLight != null
                            ? provider.inTheSpotLight.length > 1 ? 260 : 130
                            : 200,
                        child: provider.inTheSpotLight != null
                            ? ListView.builder(
                                scrollDirection: Axis.horizontal,
                                // shrinkWrap: true,
                                itemCount: provider.inTheSpotLight.length > 1
                                    ? provider.inTheSpotLight.length ~/ 2
                                    : provider.inTheSpotLight.length,
                                itemBuilder: (ctex, index) {
                                  // var index1 = index + 1;
                                  if (index > 0 && index ~/ 2 != 0) {
                                    return Container();
                                  } else {
                                    return Column(
                                      children: <Widget>[
                                        StoreCard(
                                          scWidth: widget.scWidth,
                                          restaurantModel:
                                              provider.inTheSpotLight[index],
                                        ),
                                        provider.inTheSpotLight.length >
                                                index + 1
                                            ? StoreCard(
                                                scWidth: widget.scWidth,
                                                restaurantModel: provider
                                                    .inTheSpotLight[index + 1],
                                              )
                                            : Container(),
                                      ],
                                    );
                                  }
                                },
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              width: widget.scWidth,
              height: 110,
              child: Consumer<HomeProvider>(
                builder: (ctx, val, _) {
                  if (val.getRecipies != null) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: val.getRecipies.length,
                      itemBuilder: (contx, index) {
                        return OptionCard(
                          title: "${val.getRecipies[index].title}",
                          networkImage: val.getRecipies[index].imgUrl,
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: widget.scWidth,
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
              width: widget.scWidth,
              height: 141,
              child: Consumer<HomeProvider>(
                builder: (ctx, provider, _) {
                  if (provider.popularBrands != null) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: provider.popularBrands.length,
                      itemBuilder: (ctxx, index) {
                        return OptionCard(
                          title: "${provider.popularBrands[index].title}",
                          networkImage:
                              "$BASE_URL${provider.popularBrands[index].profilePicture}",
                          secondTitle:
                              "${provider.popularBrands[index].avgDeliveryTime} mins",
                        );
                      },
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Container(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              width: widget.scWidth,
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
            Consumer<HomeProvider>(
              builder: (ctx, provider, _) {
                if (provider.restaurantsNearBy != null) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(left: 10),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: provider.restaurantsNearBy.length,
                    itemBuilder: (ctex, index) {
                      return StoreCard(
                        scWidth: widget.scWidth + 20,
                        restaurantModel: provider.restaurantsNearBy[index],
                      );
                    },
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: FlatButton(
                onPressed: () {},
                child: Text("Seel All Restaurants"),
                color: primary,
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Container(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              width: widget.scWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Near by Store",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    "Best Grocery near you",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Consumer<HomeProvider>(
              builder: (ctx, provider, _) {
                if (provider.storesNearBy != null) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(left: 10),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: provider.storesNearBy.length,
                    itemBuilder: (ctex, index) {
                      return StoreCard(
                        scWidth: widget.scWidth + 20,
                        restaurantModel: provider.storesNearBy[index],
                      );
                    },
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: FlatButton(
                onPressed: () {},
                child: Text("Seel All Stores"),
                color: primary,
              ),
            ),
            Divider(
              thickness: 2,
            )
          ],
        ),
      ),
    );
  }
}
