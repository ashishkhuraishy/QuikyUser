import 'package:flutter/material.dart';

class NotificationMessege extends StatelessWidget {
  const NotificationMessege({
    Key key,
    this.important,
  }) : super(key: key);

  final bool important;

  @override
  Widget build(BuildContext context) {
    return important != null
        ? Messege(
            val: Colors.deepOrange[100],
          )
        : Messege(
            val: Colors.grey[200],
          );
  }
}

class Messege extends StatelessWidget {
  const Messege({Key key, this.val}) : super(key: key);
  final Color val;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: val,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Food Ready ',
                      style: Theme.of(context).textTheme.headline6,
                      children: <TextSpan>[
                        TextSpan(
                          text: '.',
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        ),
                      ],
                    ),
                  ),
                  Text('4:58 PM'),
                ],
              ),
              Column(
                children: [
                  Text(
                      'Delivery the order soon as possible,your order will be delivery with in 30 minuets '),
                ],
              )
            ],
          )),
    );
  }
}
