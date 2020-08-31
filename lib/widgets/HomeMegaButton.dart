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
      margin: EdgeInsets.only(left: 20, top: 20, bottom: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      width: scWidth / 2 - 30,
      height: scWidth / 2 - 50,
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.end,
        alignment: Alignment.centerRight,
        children: <Widget>[
          Positioned(
            left: 10,
            top: 10,
            child: Text(
              "$title",
              style: whiteBold16,
            ),
          ),
          Positioned(
            bottom: -22,
            right: -22,
            child: Container(
              padding:
                  EdgeInsets.only(top: 17, left: 17, bottom: 22, right: 22),
              decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(500)),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image.asset(
                  '$image',
                  width: 100,
                  height: 100,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
