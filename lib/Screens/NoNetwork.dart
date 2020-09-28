import 'package:flutter/material.dart';

class NoNetWork extends StatelessWidget {
  const NoNetWork({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Text("No Internet !"),
          RaisedButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/home');
            },
            child: Text("Retry"),
          )
        ],
      )),
    );
  }
}
