import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiky_user/Screens/home.dart';
import 'package:quiky_user/Screens/selectlocation.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WatchBoxBuilder(
      box: Hive.box('Address'),
      builder: (context, box) {
        print(box.toString());
        if (box.isNotEmpty) {
          return Home();
        } else {
          return SelectLocation();
        }
      },
    );
  }
}
