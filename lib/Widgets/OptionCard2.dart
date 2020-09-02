import 'package:flutter/material.dart';

class OptionCard2 extends StatelessWidget {
  const OptionCard2({
    Key key,
    @required this.title,
    this.image,
    this.icon,
    this.secondTitle,
    this.networkImage,
    this.padding,
    this.onTap,
  }) : super(key: key);

  final Icon icon;
  final String title;
  final String image;
  final String networkImage;
  final String secondTitle;
  final EdgeInsets padding;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 100,
        ),
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
        child: Column(
          children: <Widget>[
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(244, 161, 30, 0.3),
                      Color.fromRGBO(237, 104, 59, 0.3)
                    ],
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, .1),
                        blurRadius: 7,
                        offset: Offset(0, 1))
                  ]),
              padding: EdgeInsets.all(2),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: Theme.of(context).scaffoldBackgroundColor),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    child: Padding(
                      padding: padding != null ? padding : EdgeInsets.all(0),
                      child: icon != null
                          ? icon
                          : networkImage != null
                              ? Image.network(
                                  networkImage,
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                )
                              : image != null
                                  ? Image.asset(
                                      image,
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.contain,
                                    )
                                  : CircularProgressIndicator(),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.headline4,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
