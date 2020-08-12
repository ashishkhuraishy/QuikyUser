import 'package:flutter/material.dart';
import 'package:quiky_user/widgets/NotificationMessege.dart';

class Notif extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
            alignment: Alignment.centerRight,
            child:
                Text('Support', style: Theme.of(context).textTheme.headline6)),
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
                    'Notifications',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    'Mark as read',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
              NotificationMessege(),
              NotificationMessege(),
              NotificationMessege(),
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
