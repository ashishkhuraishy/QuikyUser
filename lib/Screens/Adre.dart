import 'package:flutter/material.dart';
import 'package:quiky_user/theme/themedata.dart';

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
                color: grey,
              ),
              Container(
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
                            Text('A28',
                                style: Theme.of(context).textTheme.bodyText1),
                            Text(', ',
                                style: Theme.of(context).textTheme.bodyText1),
                            Text('Green Acress',
                                style: Theme.of(context).textTheme.bodyText1),
                            Text(', ',
                                style: Theme.of(context).textTheme.bodyText1),
                            Text('Ayyappan Kavu',
                                style: Theme.of(context).textTheme.bodyText1),
                            Text(', ',
                                style: Theme.of(context).textTheme.bodyText1),
                            Text('Kochi',
                                style: Theme.of(context).textTheme.bodyText1),
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
              ),
              Divider(
                thickness: 1,
                color: grey,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hashiq',
                        ),
                        Row(
                          children: [
                            Text('A28',
                                style: Theme.of(context).textTheme.bodyText1),
                            Text(', ',
                                style: Theme.of(context).textTheme.bodyText1),
                            Text('Valiayakath',
                                style: Theme.of(context).textTheme.bodyText1),
                            Text(', ',
                                style: Theme.of(context).textTheme.bodyText1),
                            Text('Vazhiyambalam',
                                style: Theme.of(context).textTheme.bodyText1),
                            Text(', ',
                                style: Theme.of(context).textTheme.bodyText1),
                            Text('kochi',
                                style: Theme.of(context).textTheme.bodyText1),
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
              ),
              Divider(
                thickness: 1,
                color: grey,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Office',
                        ),
                        Row(
                          children: [
                            Text('A28',
                                style: Theme.of(context).textTheme.bodyText1),
                            Text(', ',
                                style: Theme.of(context).textTheme.bodyText1),
                            Text('Valiayakath',
                                style: Theme.of(context).textTheme.bodyText1),
                            Text(', ',
                                style: Theme.of(context).textTheme.bodyText1),
                            Text('Vazhiyambalam',
                                style: Theme.of(context).textTheme.bodyText1),
                            Text(', ',
                                style: Theme.of(context).textTheme.bodyText1),
                            Text('kochi',
                                style: Theme.of(context).textTheme.bodyText1),
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
              ),
            ],
          ),
        ),
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
