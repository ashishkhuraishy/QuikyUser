import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({
    Key key,
    @required this.title,
    this.image,
    this.icon,
    this.secondTitle,
    this.networkImage,
  }) : super(key: key);

  final Icon icon;
  final String title;
  final String image;
  final String networkImage;
  final String secondTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 100,
      ),
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(50)),
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
                            fit: BoxFit.cover,
                          )
                        : CircularProgressIndicator(),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText1,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          secondTitle != null
              ? Text(
                  secondTitle,
                  style: Theme.of(context).textTheme.subtitle1,
                  maxLines: 1,
                )
              : Container()
        ],
      ),
    );
  }
}
