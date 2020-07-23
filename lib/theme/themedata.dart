import 'package:flutter/material.dart';

Color primary = Color.fromRGBO(244, 166, 44, 1);
Color bgSecondary = Color.fromRGBO(242, 243, 247, 1);
Color dark = Color.fromRGBO(80, 82, 93, 1);
Color grey = Color.fromRGBO(148, 149, 152, 1);
Color success = Color.fromRGBO(0, 166, 82, 1);

Map<int, Color> whiteMaterial = {
  50: Color.fromRGBO(255, 255, 255, .1),
  100: Color.fromRGBO(255, 255, 255, .2),
  200: Color.fromRGBO(255, 255, 255, .3),
  300: Color.fromRGBO(255, 255, 255, .4),
  400: Color.fromRGBO(255, 255, 255, .5),
  500: Color.fromRGBO(255, 255, 255, .6),
  600: Color.fromRGBO(255, 255, 255, .7),
  700: Color.fromRGBO(255, 255, 255, .8),
  800: Color.fromRGBO(255, 255, 255, .9),
  900: Color.fromRGBO(255, 255, 255, 1),
};

TextStyle whiteBold16 = new TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);
TextStyle whiteBold13 = new TextStyle(
  color: Colors.white,
  fontSize: 13,
  fontWeight: FontWeight.bold,
);
TextStyle white14 = new TextStyle(
  color: Colors.white,
  fontSize: 14,
);
TextStyle white13 = new TextStyle(
  color: Colors.white,
  fontSize: 13,
);
// TextStyle darkBold16 = new TextStyle(
//   fontWeight: FontWeight.bold,
//   fontSize: 16,
//   // color: dark,
// );
// TextStyle darkBold14 = new TextStyle(
//   fontWeight: FontWeight.bold,
//   fontSize: 14,
//   // color: dark,
// );
TextStyle primaryBold14 = new TextStyle(
  fontWeight: FontWeight.bold,
  color: primary,
  fontSize: 13,
);
// TextStyle dark14 = new TextStyle(
//   fontWeight: FontWeight.normal,
//   fontSize: 13,
//   // color: dark,
// );
// TextStyle grey14 = new TextStyle(
//   fontWeight: FontWeight.normal,
//   fontSize: 13,
//   color: grey,
// );
// TextStyle grey11 = new TextStyle(
//   fontWeight: FontWeight.bold,
//   fontSize: 11,
// );
TextStyle primary13 = new TextStyle(
  color: primary,
  fontSize: 13,
);
TextStyle success13 = new TextStyle(
  color: success,
  fontSize: 13,
);

Image mapPionter = Image.asset('assets/img/map-pointer.png');

InputDecoration searchDecoration(String hint) => InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(width: 1, style: BorderStyle.none, color: grey),
      ),
      hintText: hint,
      contentPadding: EdgeInsets.only(left: 16, bottom: 0),
      // fillColor: bglight1,
      // filled: true,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(width: 1, style: BorderStyle.solid, color: grey),
      ),
    );

class CustomBorderedButton extends StatelessWidget {
  const CustomBorderedButton({
    Key key,
    this.onTap,
    this.child,
  }) : super(key: key);
  final Function() onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onTap,
      child: child,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: BorderSide(color: primary),
      ),
      padding: EdgeInsets.all(0),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
