import 'package:flutter/material.dart';
import 'package:quiky_user/features/location_service/domain/entity/address.dart';

class AddressItem extends StatelessWidget {
  const AddressItem({
    Key key,
    this.data,
  }) : super(key: key);
  final Address data;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 65,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${data.shortAddress}",
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis,
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
            onSelected: (val) {},
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
