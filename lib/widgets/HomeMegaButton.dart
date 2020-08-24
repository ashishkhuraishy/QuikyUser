import 'package:flutter/material.dart';
import 'package:quiky_user/theme/themedata.dart';

class HomeMegaButton extends StatelessWidget {
  const HomeMegaButton({
    Key key,
    @required this.scWidth,
    @required this.image,
    @required this.title,
    @required this.color,
  }) : super(key: key);

  final double scWidth;
  final String image;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left:20,top:20,bottom:20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      width: scWidth / 2 - 30,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Restaurants",
              style: whiteBold16,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image.asset('assets/img/plate-of-food.png'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
