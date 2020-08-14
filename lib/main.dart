import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:quiky_user/Screens/Login.dart';
import 'package:quiky_user/Screens/Signup.dart';
import 'package:quiky_user/Screens/home.dart';
import 'package:quiky_user/core/Providers/UserProvider.dart';

import 'Screens/Store.dart';
import 'Screens/selectlocation.dart';
import 'core/Providers/AddressProvider.dart';
import 'core/Providers/HomeProvider.dart';
import 'features/location_service/data/data_source/address_local_data_sourc.dart';
import 'features/location_service/data/model/address_model.dart';
import 'features/user/data/datasource/user_local_data_source.dart';
import 'features/user/data/model/user_model.dart';
import 'injection_container.dart' as container;
import 'theme/themedata.dart';
import 'wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await container.init();
  // DB Inits
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(AddressModelAdapter());
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox(ADDRESS_BOX);
  await Hive.openBox(CORE_BOX);
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
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
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
          appBarTheme: AppBarTheme(color: Colors.white),

          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide:
                  BorderSide(width: 1, style: BorderStyle.none),
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
          '/signup': (context) => Signup(),
          '/login': (context) => Login(),
          '/home': (context) => Home(),
        },
        home: Wrapper(),
      ),
    );
  }
}
