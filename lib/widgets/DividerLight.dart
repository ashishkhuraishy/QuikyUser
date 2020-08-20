import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DividerLight extends StatelessWidget {
  const DividerLight({
    Key key,
    @required this.scWidth,
  }) : super(key: key);

  final double scWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: scWidth,
      height: 8,
      color: Theme.of(context).secondaryHeaderColor,
    );
  }
}
