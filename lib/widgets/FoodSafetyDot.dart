
import 'package:flutter/material.dart';
import 'package:quiky_user/theme/themedata.dart';

class FoodSafetyDot extends StatelessWidget {
  const FoodSafetyDot({
    Key key, this.color,
  }) : super(key: key);
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(width:2,color: success,),
        color: Colors.white
      ),
      width: 20,
      height: 20,
      child: CircleAvatar(
        backgroundColor: color!=null?color: success,
      ),
    );
  }
}
