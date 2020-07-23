import 'package:flutter/material.dart';
import 'package:quiky_user/theme/themedata.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({
    Key key,
    @required this.title,
    @required this.image,
    this.secondTitle,
  }) : super(key: key);

  final String title;
  final String image;
  final String secondTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              child: Image.asset(
                image,
                width: 70,
              )),
          Text(title,style: Theme.of(context).textTheme.bodyText1,),
          secondTitle != null ? Text(secondTitle,style: Theme.of(context).textTheme.subtitle1,): Container()
        ],
      ),
    );
  }
}
