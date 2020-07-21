import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:hive/hive.dart';
import 'package:quiky_user/Constants/Apikeys.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quiky_user/Models/address/AddressModel.dart';

class SelectLocation extends StatefulWidget {
  static final kInitialPosition = LatLng(-33.8567844, 151.213108);

  @override
  _SelectLocationState createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  PickResult selectedPlace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Map Place Picer Demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("Load Google Map"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PlacePicker(
                        apiKey: ApiKeys.mapApiKey,
                        initialPosition: SelectLocation.kInitialPosition,
                        useCurrentLocation: true,
                        //usePlaceDetailSearch: true,
                        onPlacePicked: (result) {
                          selectedPlace = result;
                          print(selectedPlace.addressComponents);
                          //Navigator.of(context).pop();
                          setState(() {});
                        },
                        //forceSearchOnZoomChanged: true,
                        //automaticallyImplyAppBarLeading: false,
                        //autocompleteLanguage: "ko",
                        //region: 'au',
                        selectInitialPosition: true,
                        selectedPlaceWidgetBuilder:
                            (_, selectedPlace, state, isSearchBarFocused) {
                          print(
                              "state: $state, isSearchBarFocused: $isSearchBarFocused");

                          /*  print(
                              '${selectedPlace.addressComponents[0].shortName}'); */
                          return isSearchBarFocused
                              ? Container()
                              : SetAddressFloatingButton(
                                  selectedPlace: selectedPlace,
                                  state: state,
                                  isSearchBarFocused: isSearchBarFocused,
                                );
                        },
                        // pinBuilder: (context, state) {
                        //   if (state == PinState.Idle) {
                        //     return Icon(Icons.favorite_border);
                        //   } else {
                        //     return Icon(Icons.favorite);
                        //   }
                        // },
                      );
                    },
                  ),
                );
              },
            ),
            /* selectedPlace == null
                ? Container()
                : Text(selectedPlace.formattedAddress ?? ""), */
          ],
        ),
      ),
    );
  }
}

class SetAddressFloatingButton extends StatelessWidget {
  final PickResult selectedPlace;
  final SearchingState state;
  final bool isSearchBarFocused;

  Box box = Hive.box('Address');

  SetAddressFloatingButton({
    this.isSearchBarFocused,
    this.selectedPlace,
    this.state,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingCard(
      bottomPosition:
          32.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
      leftPosition: 16.0,
      rightPosition: 16.0,
      elevation: 16.0,
      //width: 500,
      borderRadius: BorderRadius.circular(12.0),
      child: state == SearchingState.Searching
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    selectedPlace.formattedAddress ?? '',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  RaisedButton(
                    colorBrightness: Brightness.dark,
                    color: Colors.black,
                    child: Text(
                      "SELECT LOCATION",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      AddressModel addressModel = AddressModel(
                        formatedAddress: selectedPlace.formattedAddress,
                        shortAddress:
                            selectedPlace.addressComponents[0].shortName,
                        latLng: LatLng(
                          selectedPlace.geometry.location.lat,
                          selectedPlace.geometry.location.lat,
                        ),
                      );
                      box.add(addressModel);
                      Navigator.pop(context);
                      print(
                        "do something with ${selectedPlace.addressComponents[0].types} data",
                      );
                      //Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
