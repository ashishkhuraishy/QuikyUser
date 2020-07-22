import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/Providers/AddressProvider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final currentAddress = Provider.of<AddressProvider>(context).currentAddress;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          currentAddress.shortAddress ?? '',
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
