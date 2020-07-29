import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:quiky_user/Screens/Store.dart';
import 'package:quiky_user/Screens/selectlocation.dart';
import 'package:quiky_user/core/Providers/AddressProvider.dart';
import 'package:quiky_user/core/Providers/HomeProvider.dart';
import 'package:quiky_user/features/location_service/data/data_source/address_local_data_sourc.dart';
import 'package:quiky_user/features/location_service/data/model/address_model.dart';
import 'package:quiky_user/theme/themedata.dart';
import 'package:quiky_user/wrapper.dart';

import 'injection_container.dart' as container;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await container.init();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(AddressModelAdapter());
  await Hive.openBox(ADDRESS_BOX);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
<<<<<<< HEAD
        ChangeNotifierProvider(
          create: (context) => AddressProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
=======
        ChangeNotifierProvider(create: (context) => AddressProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
>>>>>>> 49f70a62e59534fa2b2da06a2d76cf76e9b4e931
      ],
      child: MaterialApp(
        title: 'Quiky',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.orange,
            brightness: Brightness.light,
            primaryColorDark: dark,
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide:
                    BorderSide(width: 1, style: BorderStyle.none, color: grey),
              ),
              contentPadding: EdgeInsets.only(left: 16, bottom: 0),
              // fillColor: bglight1,
              // filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide:
                    BorderSide(width: 1, style: BorderStyle.solid, color: grey),
              ),
            ),
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
<<<<<<< HEAD
=======
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide:
                  BorderSide(width: 1, style: BorderStyle.none, color: grey),
            ),
            contentPadding: EdgeInsets.only(left: 16, bottom: 0),
            // fillColor: bglight1,
            // filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide:
                  BorderSide(width: 1, style: BorderStyle.solid, color: grey),
            ),
          ),
>>>>>>> 49f70a62e59534fa2b2da06a2d76cf76e9b4e931
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
<<<<<<< HEAD
=======
            bodyText2: TextStyle(
              //dark14
              fontWeight: FontWeight.normal,
              fontSize: 14,
              // color: dark,
            ),
>>>>>>> 49f70a62e59534fa2b2da06a2d76cf76e9b4e931
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
