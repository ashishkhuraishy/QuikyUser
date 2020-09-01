import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quiky_user/Widgets/location_picker.dart';
import 'package:quiky_user/core/Providers/AddressProvider.dart';
import 'package:quiky_user/features/location_service/data/data_source/address_local_data_sourc.dart';
import 'package:quiky_user/features/location_service/domain/entity/address.dart';
import 'package:quiky_user/theme/themedata.dart';

import 'package:quiky_user/widgets/AddressItem.dart';

class AddressBook extends StatelessWidget {
  void displayOfferBottomSheet(
      BuildContext context, Address data, Function delete) {
    final key = GlobalKey<FormState>();

    String finalAddress = data.formattedAddress.split(", House")[0],
        flatno = data.formattedAddress
            .split(", House / Flat No: ")[1]
            .split(', LandMark:')[0],
        landmark = data.formattedAddress
            .split(", House / Flat No: ")[1]
            .split(', LandMark:')[1];
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return BottomSheet(
          onClosing: () {},
          builder: (BuildContext context) {
            return Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          children: [
                            TextFormField(
                              onChanged: (value) => finalAddress = value,
                              onSaved: (newValue) => finalAddress = newValue,
                              textAlign: TextAlign.left,
                              maxLines: 3,
                              initialValue:
                                  data.formattedAddress.split(", House")[0] ??
                                      '',
                              validator: (value) => value.isEmpty
                                  ? 'Address Cannot be empty'
                                  : null,
                              style: Theme.of(context).textTheme.bodyText2,
                              decoration: underlined(hint: "Address:"),
                            ),
                            TextFormField(
                              onChanged: (value) => flatno = value,
                              onSaved: (newValue) => flatno = newValue,
                              maxLines: 1,
                              initialValue: flatno ?? '',
                              style: Theme.of(context).textTheme.bodyText2,
                              decoration: underlined(hint: "House / Flat No:"),
                            ),
                            TextFormField(
                              onChanged: (value) => landmark = value,
                              onSaved: (newValue) => landmark = newValue,
                              maxLines: 1,
                              initialValue: landmark ?? '',
                              style: Theme.of(context).textTheme.bodyText2,
                              decoration: underlined(hint: "Land Mark:"),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        child: FlatButton(
                          colorBrightness: Brightness.dark,
                          color: primary,
                          child: Text(
                            "Confirm",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            if (key.currentState.validate()) {
                              key.currentState.save();
                              finalAddress =
                                  '$finalAddress, House / Flat No: $flatno, LandMark: $landmark ';
                              Address addressModel = Address(
                                formattedAddress: finalAddress,
                                shortAddress: data.shortAddress,
                                lat: data.lat,
                                long: data.long,
                              );
                              delete();
                              Provider.of<AddressProvider>(context,
                                      listen: false)
                                  .cacheCurrentAddress(addressModel);
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Box addressBox = Hive.box(ADDRESS_BOX);
    return Scaffold(
      appBar: AppBar(
        title: Text("Address Book"),
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return LoctionPicker();
                },
              ));
            },
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addressBox != null
                    ? ValueListenableBuilder<Box>(
                        valueListenable: addressBox.listenable(),
                        builder: (context, Box box, _) {
                          // Map<dynamic, dynamic> data = box.toMap();
                          // List sData = data.values.toList();
                          return SingleChildScrollView(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: box.length,
                              itemBuilder: (context, index) {
                                print(box.getAt(index));
                                return AddressItem(
                                  data: box.getAt(index) as Address,
                                  delete: () {
                                    box.deleteAt(index);
                                  },
                                  edit: () {
                                    displayOfferBottomSheet(
                                      context,
                                      box.getAt(index) as Address,
                                      () {
                                        box.deleteAt(index);
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        },
                      )
                    : Text("Address is empty")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
