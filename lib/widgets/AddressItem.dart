import 'package:flutter/material.dart';

class AddressItem extends StatelessWidget {
  const AddressItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Home',
              ),
              Row(
                children: [
                  Text('A28', style: Theme.of(context).textTheme.bodyText1),
                  Text(', ', style: Theme.of(context).textTheme.bodyText1),
                  Text('Green Acress',
                      style: Theme.of(context).textTheme.bodyText1),
                  Text(', ', style: Theme.of(context).textTheme.bodyText1),
                  Text('Ayyappan Kavu',
                      style: Theme.of(context).textTheme.bodyText1),
                  Text(', ', style: Theme.of(context).textTheme.bodyText1),
                  Text('Kochi', style: Theme.of(context).textTheme.bodyText1),
                ],
              )
            ],
          ),
          PopupMenuButton<String>(
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
