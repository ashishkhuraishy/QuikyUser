import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:quiky_user/Screens/CartTab.dart';
import 'package:quiky_user/Screens/ProfileTab.dart';
import 'package:quiky_user/Screens/SearchTab.dart';
import 'package:quiky_user/core/Providers/AddressProvider.dart';
import 'package:quiky_user/core/Providers/UserProvider.dart';
import 'package:quiky_user/features/location_service/domain/entity/address.dart';
import 'package:quiky_user/theme/themedata.dart';
import 'package:quiky_user/widgets/HomeMegaButton.dart';
import 'package:quiky_user/widgets/DividerLight.dart';
import 'package:quiky_user/widgets/OptionCard.dart';
import 'package:quiky_user/widgets/StoreCard.dart';

import 'HomeTab.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  // Address currentAddress;
  @override
  void initState() {
    // final currentAddress = Provider.of<AddressProvider>(context,listen: false).currentAddress;
    controller = TabController(length: 4, vsync: this);
    controller.addListener(tabListener);
    super.initState();
  }

  TabController controller;

  void tabListener(){
    if(controller.indexIsChanging && controller.index==3 && Provider.of<UserProvider>(context, listen: false).getUser==null){
      controller.index=controller.previousIndex;
      Navigator.of(context).pushNamed('/signup');
    }
  }

  @override
  Widget build(BuildContext context) {
    double scWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: TabBarView(
        children: <Widget>[
          HomeTab(scWidth: scWidth),
          SearchTab(),
          CartTab(),
          ProfileTab(),
        ],
        controller: controller,
      ),
      bottomNavigationBar: TabBar(
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
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "1",
                        style: whiteBold13,
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
    );
  }
}
