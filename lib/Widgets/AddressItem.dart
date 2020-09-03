import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiky_user/core/Providers/AddressProvider.dart';
import 'package:quiky_user/features/location_service/domain/entity/address.dart';

class AddressItem extends StatelessWidget {
  const AddressItem({
    Key key,
    this.data,
    this.delete,
    this.edit,
  }) : super(key: key);
  final Address data;
  final Function delete;
  final Function edit;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 3, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 65,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    "${data.shortAddress}",
                    style: Theme.of(context).textTheme.headline6,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "${data.formattedAddress}",
                  style: Theme.of(context).textTheme.bodyText1,
                  overflow: TextOverflow.visible,
                  maxLines: 3,
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (val) {
              if (val == 'Select') {
                // AddressModel add = data;
                Provider.of<AddressProvider>(context, listen: false)
                    .makeCurrentAddress(data);
              } else if (val == 'Delete') {
                delete();
              } else if (val == 'Edit') {
                edit();
              }
            },
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
    );
  }
}

class Constants {
  static const String Select = 'Select';
  static const String Edit = 'Edit';
  static const String Delete = 'Delete';

  static const List<String> choices = <String>[Select, Edit, Delete];
}
