import 'package:flutter/material.dart';
import 'package:quiky_user/widgets/NotificationMessege.dart';

class Notif extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text('Notifications',
                style: Theme.of(context).textTheme.headline6)),
        actions: [
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    'Mark as read',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
              Divider(
                thickness: 2,

              ),
              NotificationMessege(important: true),
              NotificationMessege(
                important: true,
              ),
              NotificationMessege(
                important: true,
              ),
              NotificationMessege(
                important: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Yesterday',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
              Divider(
                thickness: 2,
              ),
              NotificationMessege(),
              NotificationMessege(),
              NotificationMessege(),
              NotificationMessege(),
            ],
          ),
        ),
      ),
    );
  }
}

class Constants {
  static const String Select = 'Select All';

  static const String Delete = 'Delete All';

  static const List<String> choices = <String>[Select, Delete];
}
