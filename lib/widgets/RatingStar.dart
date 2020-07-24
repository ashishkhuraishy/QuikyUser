
import 'package:flutter/material.dart';
import 'package:quiky_user/theme/themedata.dart';

class RatingStarIdicator extends StatelessWidget {
  const RatingStarIdicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(Icons.star,size: 15,color: primary,),
        Icon(Icons.star,size: 15,color: primary,),
        Icon(Icons.star,size: 15,color: primary,),
        Icon(Icons.star,size: 15,color: primary,),
        Icon(Icons.star_half,size: 15,color: primary,),
        Text(" 4.6 ",style:Theme.of(context).textTheme.bodyText1),
        Text(" (1200 Reviews) ",style:Theme.of(context).textTheme.subtitle1),
      ],
    );
  }
}