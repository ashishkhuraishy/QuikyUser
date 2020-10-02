import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:quiky_user/Screens/NoNetwork.dart';
import 'package:quiky_user/Screens/OrderPlaced.dart';
import 'package:quiky_user/Screens/Orders.dart';
import 'package:quiky_user/Screens/TrackOrder.dart';
import 'package:quiky_user/core/Services/push_notifiactions_service.dart';

import 'Screens/AddressBook.dart';
import 'Screens/AllStore.dart';
import 'Screens/Login.dart';
import 'Screens/Signup.dart';
import 'Screens/Store.dart';
import 'Screens/home.dart';
import 'Screens/selectlocation.dart';
import 'core/Providers/AddressProvider.dart';
import 'core/Providers/CartProvider.dart';
import 'core/Providers/HomeProvider.dart';
import 'core/Providers/UserProvider.dart';
import 'features/cart/domain/entity/cart.dart';
import 'features/cart/domain/entity/cart_item.dart';
import 'features/home/domain/entity/offer.dart';
import 'features/location_service/data/data_source/address_local_data_sourc.dart';
import 'features/location_service/domain/entity/address.dart';
import 'features/user/data/datasource/user_local_data_source.dart';
import 'features/user/domain/entity/user.dart';
import 'injection_container.dart' as container;
import 'theme/themedata.dart';
import 'wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await container.init();
  // DB Inits
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter<Address>(AddressAdapter());
  Hive.registerAdapter<Cart>(CartAdapter());
  Hive.registerAdapter<Offer>(OfferAdapter());
  Hive.registerAdapter<CartItem>(CartItemAdapter());
  Hive.registerAdapter<User>(UserAdapter());
  await Hive.openBox(CORE_BOX);
  await Hive.openBox(ADDRESS_BOX);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final PushNotificationService pushNotificationService =
      PushNotificationService();
  final FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics();
  @override
  Widget build(BuildContext context) {
    pushNotificationService.init(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AddressProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Quiky',
        debugShowCheckedModeBanner: false,
        navigatorObservers: [
          FirebaseAnalyticsObserver(
            analytics: firebaseAnalytics,
          ),
        ],
        theme: ThemeData(
          primarySwatch: Colors.orange,
          brightness: Brightness.light,
          primaryColorDark: dark,
          textTheme: TextTheme(
            headline5: TextStyle(
                //darkbold16
                fontWeight: FontWeight.bold,
                fontSize: 16, //16
                color: dark,
                fontFamily: 'Roboto'),
            headline6: TextStyle(
                //darkbold14
                fontWeight: FontWeight.bold,
                fontSize: 13, //14
                color: dark,
                fontFamily: 'Roboto'),
            bodyText1: TextStyle(
                //dark14
                fontWeight: FontWeight.normal,
                fontSize: 12, //13
                color: dark,
                fontFamily: 'Roboto'),
            subtitle1: TextStyle(
                //grey14
                fontWeight: FontWeight.normal,
                fontSize: 12, //13
                color: grey,
                fontFamily: 'Roboto'),
            subtitle2: new TextStyle(
                //grey11
                fontWeight: FontWeight.bold,
                fontSize: 10, //11
                color: grey,
                fontFamily: 'Roboto'),
            headline4: new TextStyle(
                //white11
                fontWeight: FontWeight.bold,
                fontSize: 10, //11
                color: dark,
                fontFamily: 'Roboto'),
          ),
          primaryColorLight: Colors.white,
          // secondaryHeaderColor: bgSecondary,
          dividerColor: bgSecondary,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(color: Colors.white),

          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(width: 1, style: BorderStyle.none),
            ),
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: primary,
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.orange,
          accentColor: Colors.orange,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide:
                  BorderSide(width: 1, style: BorderStyle.none, color: grey),
            ),
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: primary,
          ),
          dividerColor: Color.fromRGBO(58, 58, 58, 1),
          scaffoldBackgroundColor: Color.fromRGBO(39, 39, 39, 1),
          textTheme: TextTheme(
            headline5: TextStyle(
                //darkbold16
                fontWeight: FontWeight.bold,
                fontSize: 16, //16
                fontFamily: 'Roboto'
                // color: dark,
                ),
            headline6: TextStyle(
                //darkbold14
                fontWeight: FontWeight.bold,
                fontSize: 13, //14
                fontFamily: 'Roboto'
                // color: dark,
                ),
            bodyText1: TextStyle(
                //dark14
                fontWeight: FontWeight.normal,
                fontSize: 12, //13
                fontFamily: 'Roboto'
                // color: dark,
                ),
            subtitle1: TextStyle(
              //grey14
              fontWeight: FontWeight.normal,
              fontSize: 12, //13
              color: Colors.grey,
              fontFamily: 'Roboto',
            ),
            subtitle2: new TextStyle(
              //grey11
              fontWeight: FontWeight.bold,
              fontSize: 10, //11
              color: Colors.grey,
              fontFamily: 'Roboto',
            ),
            headline4: new TextStyle(
              //white11
              fontWeight: FontWeight.bold,
              fontSize: 10, //11
              color: Colors.white,
              fontFamily: 'Roboto',
            ),
          ),
        ),
        themeMode: ThemeMode.system,
        routes: {
          '/selectlocation': (context) => SelectLocation(),
          '/store': (context) => Store(),
          '/signup': (context) => Signup(),
          '/login': (context) => Login(),
          '/home': (context) => Home(),
          '/address-book': (context) => AddressBook(),
          '/allstore': (context) => AllStore(),
          '/currentOrder': (context) => Orders(),
          '/nonetwork': (context) => NoNetWork(),
          '/orderplaced': (context) => OrderPlaced(),
        },
        onGenerateRoute: (settings) {
          var routes = <String, WidgetBuilder>{
            "/trackOrder": (ctx) =>
                TrackOrderW(orderdetails: settings.arguments),
          };

          WidgetBuilder builder = routes[settings.name];
          return MaterialPageRoute(builder: (ctx) => builder(ctx));
        },
        home: Wrapper(),
      ),
    );
  }
}
