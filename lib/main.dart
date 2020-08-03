import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screens/Store.dart';
import 'Screens/selectlocation.dart';
import 'core/Providers/AddressProvider.dart';
import 'core/Providers/HomeProvider.dart';
import 'injection_container.dart' as container;
import 'theme/themedata.dart';
import 'wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await container.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AddressProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Quiky',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.orange,
            brightness: Brightness.light,
            primaryColorDark: dark,
            textTheme: TextTheme(
              headline5: TextStyle(
                //darkbold16
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: dark,
              ),
              headline6: TextStyle(
                //darkbold14
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: dark,
              ),
              bodyText1: TextStyle(
                //dark14
                fontWeight: FontWeight.normal,
                fontSize: 13,
                color: dark,
              ),
              subtitle1: TextStyle(
                //grey14
                fontWeight: FontWeight.normal,
                fontSize: 13,
                color: grey,
              ),
              subtitle2: new TextStyle(
                //grey11
                fontWeight: FontWeight.bold,
                fontSize: 11,
                color: grey,
              ),
            ),
            primaryColorLight: Colors.white,
            // secondaryHeaderColor: bgSecondary,
            dividerColor: bgSecondary,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            appBarTheme: AppBarTheme(color: Colors.white)),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.orange,
          accentColor: Colors.orange,
          // toggleableActiveColor: Colors.red,
          dividerColor: Color.fromRGBO(58, 58, 58, 1),
          scaffoldBackgroundColor: Color.fromRGBO(39, 39, 39, 1),
          // secondaryHeaderColor: bgSecondary,
          textTheme: TextTheme(
            headline5: TextStyle(
              //darkbold16
              fontWeight: FontWeight.bold,
              fontSize: 16,
              // color: dark,
            ),
            headline6: TextStyle(
              //darkbold14
              fontWeight: FontWeight.bold,
              fontSize: 14,
              // color: dark,
            ),
            bodyText1: TextStyle(
              //dark14
              fontWeight: FontWeight.normal,
              fontSize: 13,
              // color: dark,
            ),
            subtitle1: TextStyle(
              //grey14
              fontWeight: FontWeight.normal,
              fontSize: 13,
              color: Colors.grey,
            ),
            subtitle2: new TextStyle(
              //grey11
              fontWeight: FontWeight.bold,
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
        ),
        themeMode: ThemeMode.system,
        routes: {
          '/selectlocation': (context) => SelectLocation(),
          '/store': (context) => Store(),
        },
        home: Wrapper(),
      ),
    );
  }
}
