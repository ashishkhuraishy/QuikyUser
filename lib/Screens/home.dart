import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiky_user/core/Providers/CartProvider.dart';
import 'package:quiky_user/core/Services/push_notifiactions_service.dart';

import '../core/Providers/UserProvider.dart';
import '../theme/themedata.dart';
import 'CartTab.dart';
import 'HomeTab.dart';
import 'ProfileTab.dart';
import 'SearchTab.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  // Address currentAddress;
  GlobalKey<ScaffoldState> homeKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // final currentAddress = Provider.of<AddressProvider>(context,listen: false).currentAddress;
    controller = TabController(length: 4, vsync: this);
    controller.addListener(tabListener);
    PushNotificationService().init(context);
    super.initState();
  }

  TabController controller;

  void tabListener() {
    if (controller.indexIsChanging &&
        controller.index == 3 &&
        Provider.of<UserProvider>(context, listen: false).getUser == null) {
      controller.index = controller.previousIndex;
      Navigator.of(context).pushNamed('/signup');
    }
  }

  navigateToCart() {
    controller.index = 2;
  }

  @override
  Widget build(BuildContext context) {
    double scWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: homeKey,
      body: TabBarView(
        children: <Widget>[
          HomeTab(scWidth: scWidth),
          SearchTab(),
          CartTab(),
          ProfileTab(),
        ],
        controller: controller,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: <BoxShadow>[
          BoxShadow(
              color: Theme.of(context).dividerColor,
              offset: Offset(0, -2),
              blurRadius: 0.0,
              spreadRadius: 0)
        ], color: Theme.of(context).scaffoldBackgroundColor),
        child: TabBar(
          controller: controller,
          labelPadding: EdgeInsets.all(0),
          indicatorPadding: EdgeInsets.all(0),
          labelColor: primary,
          unselectedLabelColor: Colors.grey,
          indicatorColor: primary,
          tabs: <Widget>[
            Tab(
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(Icons.home),
                  Text("QUIKY", style: textBold11)
                ],
              ),
            ),
            Tab(
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(Icons.search),
                  Text(
                    "SEARCH",
                    style: textBold11,
                  )
                ],
              ),
            ),
            Tab(
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.shopping_cart),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5)),
                        child: Consumer<CartProvider>(
                          builder: (ctx, provider, _) {
                            return Text(
                              "${provider.currentProducts.length}",
                              style: whiteBold13,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  Text(
                    "MY CART",
                    style: textBold11,
                  )
                ],
              ),
            ),
            Tab(
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(Icons.account_circle),
                  Text(
                    "PROFILE",
                    style: textBold11,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
