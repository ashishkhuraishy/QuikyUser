import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'Screens/home.dart';
import 'Screens/selectlocation.dart';
import 'core/Providers/AddressProvider.dart';
import 'features/location_service/data/data_source/address_local_data_sourc.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    Box addressBox = Hive.box(ADDRESS_BOX);
    if (addressBox.isEmpty)
      return SelectLocation();
    else {
      Provider.of<AddressProvider>(context, listen: false).getCurrentAddress();
      return Home();
    }
  }
}
