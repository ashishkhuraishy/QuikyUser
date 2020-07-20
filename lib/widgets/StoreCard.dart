
import 'package:flutter/widgets.dart';
import 'package:quiky_user/theme/themedata.dart';

class StoreCard extends StatelessWidget {
  const StoreCard({
    Key key,
    @required this.scWidth,
  }) : super(key: key);

  final double scWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right:10,bottom:10,top:10,),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
                                  child: Image.asset(
              "assets/img/Burger.jpeg",
              width: 90,
              height: 110,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            constraints: BoxConstraints(
              maxWidth:  scWidth-130,
            ),
            height: 110,
            padding: const EdgeInsets.only(left:10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Arabian Paradise hotel edappally kerala india india  india", style: darkBold16,overflow: TextOverflow.ellipsis,maxLines: 1,),
                // Spacer(flex:1),
                Text("Arabian, South indian", style: grey14,overflow: TextOverflow.ellipsis,),
                Text("Edappally | 1.9kms", style: grey14,overflow: TextOverflow.ellipsis,),
                // Spacer(flex:8),
                Text("★4.5 • 28 mins • ₹200 for two",style:dark14,overflow: TextOverflow.ellipsis,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
