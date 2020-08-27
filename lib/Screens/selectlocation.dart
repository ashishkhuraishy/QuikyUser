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
      appBar: AppBar(
        title: Text("Quiky Select Location"),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(
              child: Image.asset('assets/img/locationintro.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              child: Center(
                child: RaisedButton(
                  child: Text("Select Location"),
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
                ),
              ),
            ),
          ),
          /* selectedPlace == null
              ? Container()
              : Text(selectedPlace.formattedAddress ?? ""), */
        ],
      ),
    );
  }
}
