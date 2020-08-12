import 'package:flutter/material.dart';

class NotificationMessege extends StatelessWidget {
  const NotificationMessege({
    Key key,
    ,
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(width: 0.5, color: Colors.grey)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/img/quiky'),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deliver the very fast',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Text(
                  'Delivery the order soon as possible, your order will',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Text(
                  'be Delivery with in 30 minuets',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Text('15 may', style: Theme.of(context).textTheme.subtitle2),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
