import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiky_user/core/Providers/AddressProvider.dart';
import 'package:quiky_user/core/error/failure.dart';
import 'package:quiky_user/features/home/domain/entity/restaurents.dart';
import '../core/Providers/CartProvider.dart';

import '../core/Services/products_listing_service.dart';
import '../features/home/data/model/restaurant_model.dart';
import '../features/products/data/models/category_model.dart';
import '../theme/themedata.dart';
import '../widgets/ProductCard.dart';
import '../widgets/RatingStar.dart';

class Store extends StatelessWidget {
  const Store({
    Key key,
  }) : super(key: key);

  Future<List> loadProducts(RestaurantModel restaurant) async {
    ProductListingService p = ProductListingService(id: restaurant.id);
    return await p.getCategories;
  }

  @override
  Widget build(BuildContext context) {
    final RestaurantModel restaurant =
        ModalRoute.of(context).settings.arguments;
    double scWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        bottomNavigationBar: InkWell(
          onTap: () {
            Navigator.pushReplacementNamed(context, '/home', arguments: 2);
            // Provider.of<Home>(context,listen: false).navigate();
          },
          child: Container(
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            width: scWidth - 30,
            height: 60,
            decoration: BoxDecoration(
              color: primary,
              // borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Consumer<CartProvider>(
                  builder: (ctx, provider, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("${provider.cartProducts.length} item",
                            style: white13),
                        Row(
                          children: <Widget>[
                            Text("₹${provider.totalPrice} ",
                                style: whiteBold13),
                            Text("plus taxes", style: white13),
                          ],
                        ),
                      ],
                    );
                  },
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
        ),
        // floatingActionButton: Column(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   crossAxisAlignment: CrossAxisAlignment.end,
        //   children: <Widget>[

        // FlatButton(
        //   shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(10)),
        //   onPressed: () {},
        //   color: Colors.redAccent,
        //   child: Text("Menu", style: whiteBold13),
        // ),
        //   ],
        // ),
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
                    Text("${restaurant.title}",
                        style: Theme.of(context).textTheme.headline5,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3),
                    RatingStarIdicator(
                        rating: restaurant.avgRating,
                        totalReview: restaurant.totalReviews),
                    Text("${restaurant.storeSubType}",
                        style: Theme.of(context).textTheme.bodyText1,
                        overflow: TextOverflow.ellipsis),
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
                            child: Consumer<AddressProvider>(
                              builder: (ctx, provider, _) {
                                return Text(
                                  "${provider.currentAddress.formattedAddress}",
                                  style: Theme.of(context).textTheme.bodyText1,
                                  maxLines: 3,
                                  overflow: TextOverflow.visible,
                                );
                              },
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
                padding: EdgeInsets.only(top: 0, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Text("₹30 Distance fee applicable", style: primary13),
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
              FutureBuilder<List>(
                future: loadProducts(restaurant),
                builder: (ctx, AsyncSnapshot<List> categories) {
                  if (categories.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: categories.data.length,
                      itemBuilder: (ctx, index) {
                        return ExpansionTileProducts(
                            scWidth: scWidth,
                            data: categories.data[index],
                            restaurant: restaurant);
                      },
                    );
                  } else if (categories.hasError) {
                    return Center(
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Something went wrong"),
                            RaisedButton(
                              onPressed: () {
                                loadProducts(restaurant);
                              },
                              child: Text("Retry"),
                            )
                          ],
                        ),
                      ),
                    );
                  } else if (categories.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Center(
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Something went wrong, Try again later"),
                            // RaisedButton(
                            //   onPressed: () {
                            //     loadProducts(restaurant);
                            //   },
                            //   child: Text("Retry"),
                            // )
                          ],
                        ),
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ));
  }
}

class ExpansionTileProducts extends StatelessWidget {
  const ExpansionTileProducts({
    Key key,
    @required this.scWidth,
    @required this.restaurant,
    this.data,
  }) : super(key: key);

  final double scWidth;
  final CategoryModel data;
  final Restaurant restaurant;

  String productTitles(List products) {
    String a = "";
    products.forEach((element) {
      a += " ${element.title}";
    });
    return a;
  }

  List<Widget> productWidgets(
      List products, BuildContext context, Restaurant store) {
    List<Widget> a = [];
    products.forEach((element) {
      a.add(ProductCard(scWidth: scWidth, data: element, store: store));
    });
    return a;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text("${data.title}",
          style: Theme.of(context).textTheme.headline5,
          overflow: TextOverflow.ellipsis),
      subtitle: Text(
          "${data.products.length} items, ${productTitles(data.products)} ",
          style: Theme.of(context).textTheme.subtitle1,
          overflow: TextOverflow.ellipsis),
      children: productWidgets(data.products, context, restaurant),
    );
  }
}
