import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiky_user/Constants/Apikeys.dart';
import 'package:quiky_user/Widgets/OptionCard2.dart';
import 'package:quiky_user/core/Providers/CartProvider.dart';
import 'package:quiky_user/core/platform/network_info.dart';
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

class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Address tempAddress;
  NetworkInfo networkInfo;

  void fetchData(Address currentAddress) {
    // final getData = Provider.of<HomeProvider>(context,listen:false).getData(currentAddress.lat, currentAddress.long);
    // Provider.of<HomeProvider>(context, listen: false).getData(currectAddress.lat,currectAddress.long);
    if (tempAddress != currentAddress) {
      tempAddress = currentAddress;
      Provider.of<HomeProvider>(context, listen: false)
          .getData(currentAddress.lat, currentAddress.long);
    }

    // .getData(10.0260688, 76.3124753);
    Provider.of<CartProvider>(context, listen: false).loadCart();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    // final currentAddress =  Provider.of<AddressProvider>(context,listen: false).currentAddress;
    // final getData = Provider.of<HomeProvider>(context,listen:false).getData(currentAddress.lat, currentAddress.long);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          // height: double.infinity,
          width: double.infinity,
          child: GestureDetector(
            onTap: () {
              final address =
                  Provider.of<AddressProvider>(context, listen: false)
                      .currentAddress;
              print(address.lat);
              print(address.long);
              Navigator.of(context).pushNamed('/address-book');
            },
            child: Row(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.location_on,
                      color: primary,
                    )),
                Consumer<AddressProvider>(
                  builder: (ctx, val, widget) {
                    if (val.currentAddress.lat > 0)
                      fetchData(val.currentAddress);
                    return Container(
                      width: MediaQuery.of(context).size.width-100,
                      child: Text(
                        "${val.currentAddress.formattedAddress}",
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headline5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
        elevation: 0.0,
      ),
      body: Consumer<HomeProvider>(
        builder: (ctx, provider, _) {
          // print(provider.popularBrands.length);
          // print(provider.restaurantsNearBy.length);
          // print(provider.storesNearBy.length);
          if (provider.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.error == 1) {
            return Center(child: Text("No network"));
          } else if (provider.error == 1) {
            return Center(child: Text("No network"));
          } else if (provider.popularBrands.length > 0 ||
              provider.restaurantsNearBy.length > 0 ||
              provider.storesNearBy.length > 0) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/img/slide.png',
                          height: 200,
                          width: 300,
                        ),
                        Image.asset(
                          'assets/img/slide.png',
                          height: 200,
                          width: 300,
                        ),
                        Image.asset(
                          'assets/img/slide.png',
                          height: 200,
                          width: 300,
                        ),
                      ],
                    ),
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
                          OptionCard2(
                              title: "MEAT",
                              image: "assets/img/meat.png",
                              padding: EdgeInsets.all(20),
                              onTap: () {
                                Navigator.pushNamed(context, '/allstore',
                                    arguments: StoreType.meat);
                              }),
                          OptionCard2(
                              title: "FISH",
                              image: "assets/img/fish.png",
                              padding: EdgeInsets.all(20),
                              onTap: () {
                                Navigator.pushNamed(context, '/allstore',
                                    arguments: StoreType.fish);
                              }),
                          OptionCard2(
                              title: "ELECTRONICS",
                              image: "assets/img/Electronics.png",
                              padding: EdgeInsets.all(20),
                              onTap: () {
                                Navigator.pushNamed(context, '/allstore',
                                    arguments: StoreType.electronics);
                              }),
                          OptionCard2(
                            title: "BULK ORDER",
                            image: "assets/img/bulk.png",
                            padding: EdgeInsets.all(20),
                            onTap: () {
                              Navigator.pushNamed(context, '/allstore',
                                  arguments: StoreType.milk);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      HomeMegaButton(
                          scWidth: widget.scWidth,
                          title: 'Grocery',
                          image: 'assets/img/store.png',
                          color: Color.fromRGBO(39, 174, 96, 1),
                          onTap: () {
                            Navigator.pushNamed(context, '/allstore',
                                arguments: StoreType.groceries);
                          }),
                      HomeMegaButton(
                          scWidth: widget.scWidth,
                          title: 'Restaurant',
                          image: 'assets/img/food.png',
                          color: Color.fromRGBO(155, 81, 224, 1),
                          onTap: () {
                            Navigator.pushNamed(context, '/allstore',
                                arguments: StoreType.restaurants);
                          }),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Consumer<HomeProvider>(
                    builder: (ctx, provider, _) {
                      print(
                          "in the spot light ${provider.inTheSpotLight.length}");
                      print(provider.inTheSpotLight);
                      if (provider.inTheSpotLight != null &&
                          provider.inTheSpotLight.length > 0) {
                        return Column(
                          children: [
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 8.0, bottom: 8),
                                        child: Image.asset(
                                          "assets/img/h.png",
                                          width: 30,
                                        ),
                                      ),
                                      Text(
                                        "In the Spotlight!",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      )
                                    ],
                                  ),
                                  Text(
                                    "Explore sponsored partner brands",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  Container(
                                    height: provider.inTheSpotLight != null
                                        ? provider.inTheSpotLight.length > 0
                                            ? 220
                                            : 130
                                        : 200,
                                    child: provider.inTheSpotLight != null
                                        ? ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            // shrinkWrap: true,
                                            physics: PageScrollPhysics(),
                                            itemCount: provider
                                                        .inTheSpotLight.length >
                                                    0
                                                ? provider.inTheSpotLight
                                                        .length ~/
                                                    2
                                                : provider
                                                    .inTheSpotLight.length,
                                            itemBuilder: (ctex, index) {
                                              // var index1 = index + 1;
                                              if (index > 0 &&
                                                  index ~/ 2 != 0) {
                                                return Container();
                                              } else {
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    StoreCard(
                                                      scWidth: widget.scWidth,
                                                      restaurantModel: provider
                                                              .inTheSpotLight[
                                                          index],
                                                    ),
                                                    provider.inTheSpotLight
                                                                .length >
                                                            index + 1
                                                        ? StoreCard(
                                                            scWidth:
                                                                widget.scWidth,
                                                            restaurantModel:
                                                                provider.inTheSpotLight[
                                                                    index + 1],
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
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  Consumer<HomeProvider>(
                    builder: (ctx, val, _) {
                      if (val.getRecipies != null &&
                          val.getRecipies.length > 0) {
                        print("asdasdasd ${val.getRecipies.length}");
                        return Column(
                          children: [
                            Container(
                                padding: EdgeInsets.only(top: 10),
                                width: widget.scWidth,
                                height: 110,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: val.getRecipies.length,
                                  itemBuilder: (contx, index) {
                                    return OptionCard(
                                      title: "${val.getRecipies[index].title}",
                                      networkImage:
                                          val.getRecipies[index].imgUrl,
                                    );
                                  },
                                )),
                            Divider(
                              thickness: 2,
                            ),
                          ],
                        );
                      } else {
                        // return Center(
                        //   child: CircularProgressIndicator(),
                        // );
                        return Container();
                      }
                    },
                  ),
                  Consumer<HomeProvider>(
                    builder: (ctx, provider, _) {
                      if (provider.popularBrands.length > 0) {
                        // print(
                        //     "poppppppppppppppppppppppppp ${provider.popularBrands}");
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              width: widget.scWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Popular Brands",
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                  Text("Most ordered from around your locality",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              width: widget.scWidth,
                              height: 141,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: provider.popularBrands.length,
                                itemBuilder: (ctxx, index) {
                                  return OptionCard(
                                    onTap: () {
                                      Navigator.of(context).pushNamed('/store',
                                          arguments:
                                              provider.popularBrands[index]);
                                    },
                                    title:
                                        "${provider.popularBrands[index].title}",
                                    networkImage:
                                        "$BASE_URL${provider.popularBrands[index].brandLogo}",
                                    secondTitle:
                                        "${provider.popularBrands[index].avgDeliveryTime} mins",
                                  );
                                },
                              ),
                            ),
                            Divider(
                              thickness: 2,
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  Consumer<HomeProvider>(
                    builder: (ctx, provider, _) {
                      if (provider.restaurantsNearBy.length > 0) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.only(top: 10, left: 10, right: 10),
                              width: widget.scWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Near by restaurants",
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                  Text(
                                    "Trending restaurants near you",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ],
                              ),
                            ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(left: 10),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: provider.restaurantsNearBy.length,
                              itemBuilder: (ctex, index) {
                                return StoreCard(
                                  scWidth: widget.scWidth + 20,
                                  restaurantModel:
                                      provider.restaurantsNearBy[index],
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/allstore',
                                      arguments: StoreType.restaurants);
                                },
                                child: Text("Seel All Restaurants"),
                                color: primary,
                              ),
                            ),
                            Divider(
                              thickness: 2,
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  Consumer<HomeProvider>(
                    builder: (ctx, provider, _) {
                      if (provider.storesNearBy.length > 0) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.only(top: 10, left: 10, right: 10),
                              width: widget.scWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Near by Store",
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                  Text(
                                    "Best Grocery near you",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ],
                              ),
                            ),
                            ListView.builder(
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
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/allstore',
                                      arguments: StoreType.groceries);
                                },
                                child: Text("Seel All Stores"),
                                color: primary,
                              ),
                            ),
                            // Divider(
                            //   thickness: 2,
                            // )
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            );
          } else {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/img/no_service.png',height: 200,),
                SizedBox(height:20),
                Text("We don't have any service near you.")
              ],
            ));
          }
        },
      ),
    );
  }
}
