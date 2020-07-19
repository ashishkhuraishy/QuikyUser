import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quiky_user/Models/address/AddressModel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Box box = Hive.box('Address');

  AddressModel address;

  @override
  void initState() {
    address = box.getAt(0) as AddressModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          address.shortAddress,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}
