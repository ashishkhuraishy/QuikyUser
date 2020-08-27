import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiky_user/features/location_service/data/data_source/address_local_data_sourc.dart';
import 'package:quiky_user/features/location_service/domain/entity/address.dart';

import 'package:quiky_user/widgets/AddressItem.dart';

class AddressBook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Box addressBox = Hive.box<Address>(ADDRESS_BOX);
    return Scaffold(
      appBar: AppBar(
        title: Text("Address Book"),
        actions: <Widget>[
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Icons.add,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addressBox != null
                  ? ValueListenableBuilder<Box<Address>>(
                      valueListenable: addressBox.listenable(),
                      builder: (context, Box<Address> box, _) {
                        // Map<dynamic, dynamic> data = box.toMap();
                        // List sData = data.values.toList();
                        return SingleChildScrollView(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: box.length,
                              itemBuilder: (context, index) {
                                print(box.getAt(index));
                                return AddressItem(data: box.getAt(index));
                              }),
                        );
                      },
                    )
                  : Text("Address is empty")
            ],
          ),
        ),
      ),
    );
  }
}
