import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quiky_user/Widgets/location_picker.dart';

class SelectLocation extends StatefulWidget {
  static final kInitialPosition = LatLng(-33.8567844, 151.213108);

  @override
  _SelectLocationState createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 4,
            child: Container(
              child: Image.asset(
                'assets/img/locationintro.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Flexible(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                    flex: 1,
                    child: Center(
                      child: Text(
                        "Order from Wide range of Stores",
                        style: Theme.of(context).textTheme.headline5,
                          overflow: TextOverflow.visible,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                      ),
                    )),
                Flexible(
                  flex: 4,
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "Ready to order from top Restaurants",
                          style: Theme.of(context).textTheme.subtitle1,
                          overflow: TextOverflow.visible,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:10.0),
                          child: RaisedButton(
                            child: Text("SET DELIVERY LOCATION"),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return LoctionPicker();
                                  },
                                ),
                              );
                            },
                            padding: EdgeInsets.symmetric(vertical:15,horizontal:10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
