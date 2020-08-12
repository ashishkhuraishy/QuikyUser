import 'package:flutter/material.dart';
import 'package:quiky_user/theme/themedata.dart';
import 'package:quiky_user/widgets/AddressItem.dart';

class Address extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Address', style: Theme.of(context).textTheme.headline5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Add Address',
                      style: Theme.of(context).textTheme.bodyText1)
                ],
              ),
              Divider(
                thickness: 1,
              ),
              AddressItem(),
              Divider(
                thickness: 1,
              ),
              AddressItem(),
              Divider(
                thickness: 1,
              ),
              AddressItem(),
            ],
          ),
        ),
      ),
    );
  }
}
