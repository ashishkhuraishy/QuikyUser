import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiky_user/features/location_service/data/data_source/address_local_data_sourc.dart';
import 'package:quiky_user/features/location_service/data/model/address_model.dart';

import 'package:quiky_user/widgets/AddressItem.dart';

class Address extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Box addressBox = Hive.box(ADDRESS_BOX);
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
              addressBox != null
                  ? WatchBoxBuilder(
                      box: addressBox,
                      builder: (context, box) {
                        Map<dynamic, dynamic> data = box.toMap();
                        List Sdata = data.values.toList();
                        return SingleChildScrollView(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                print(data[index]);
                                return AddressItem(data: data[index]);
                              }),
                        );
                      })
                  : Text("Address is empty")
            ],
          ),
        ),
      ),
    );
  }
}
