import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/Providers/UserProvider.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (ctx, provider, _) {
          if (provider.getUser == null) {
            return Center(
              child: Column(
                children: [
                  Image.asset("assets/img/please_login.png"),
                  RaisedButton(
                    child: Text(
                      "Login",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/signup');
                    },
                  ),
                ],
              ),
            );
          } else {
            return SafeArea(
                child: SingleChildScrollView(
                    child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("${provider.getUser.name}",
                              style: Theme.of(context).textTheme.headline5),
                          // Text("${provider.getUser.email}",
                          //     style: Theme.of(context).textTheme.bodyText1),
                          Text("${provider.getUser.mobile}",
                              style: Theme.of(context).textTheme.bodyText1),
                        ],
                      ),
                      Container(
                        child: Icon(
                          Icons.account_circle,
                          size: 80,
                        ),
                      )
                    ],
                  ),
                ),
                // Divider(
                //   thickness: 8,
                // ),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Container(
                //     padding: EdgeInsets.symmetric(vertical: 10),
                //     constraints: BoxConstraints(
                //       minWidth: scWidth,
                //     ),
                //     height: 87,
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       mainAxisSize: MainAxisSize.max,
                //       children: <Widget>[
                //         OptionCard(
                //           title: "Track Order",
                //           icon: Icon(
                //             Icons.local_shipping,
                //             size: 40,
                //           ),
                //         ),
                //         OptionCard(
                //           title: "Notification",
                //           icon: Icon(
                //             Icons.notifications,
                //             size: 40,
                //           ),
                //         ),
                //         OptionCard(
                //           title: "Help",
                //           icon: Icon(
                //             Icons.help_outline,
                //             size: 40,
                //           ),
                //         ),
                //         OptionCard(
                //           title: "Payments",
                //           icon: Icon(
                //             Icons.payment,
                //             size: 40,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                Divider(
                  thickness: 8,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      CustomRowButton(
                        onTap: () {
                          Navigator.pushNamed(context, '/currentOrder');
                        },
                        icon: Icon(Icons.shopping_basket),
                        title: "My Order",
                      ),
                      // CustomRowButton(
                      //   onTap: () {},
                      //   icon: Icon(Icons.favorite_border),
                      //   title: "Past Orders",
                      // ),
                      CustomRowButton(
                        onTap: () {
                          Navigator.of(context).pushNamed('/address-book');
                        },
                        icon: Icon(Icons.book),
                        title: "Address Book",
                      ),
                      CustomRowButton(
                        onTap: () async {
                          const url = 'https://quiky.in';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        title: "About",
                      ),
                      CustomRowButton(
                        onTap: () async {
                          const url = 'https://quiky.in';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        title: "Terms And Condition",
                      ),
                      CustomRowButton(
                        onTap: () async {
                          const url = 'https://play.google.com/store/apps/details?id=com.abi.grocyapp';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        title: "Rate Us on PlayStore",
                      ),
                      CustomRowButton(
                        onTap: () async {
                          const url = 'https://quiky.in';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        title: "Contact Us",
                      ),
                      CustomRowButton(
                        onTap: () async {
                          await Provider.of<UserProvider>(context,
                                  listen: false)
                              .logOut();
                          Navigator.of(context).popAndPushNamed('/home');
                        },
                        title: "Logout",
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 8,
                ),
              ],
            )));
          }
        },
      ),
    );
  }
}

class CustomRowButton extends StatelessWidget {
  const CustomRowButton({
    Key key,
    this.onTap,
    this.icon,
    this.title,
  }) : super(key: key);

  final Function onTap;
  final Icon icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                icon != null ? icon : Container(),
                Padding(
                  padding: EdgeInsets.only(left: icon != null ? 20.0 : 0),
                  child: Text(
                    "$title",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ],
            ),
            Icon(Icons.keyboard_arrow_right)
          ],
        ));
  }
}
