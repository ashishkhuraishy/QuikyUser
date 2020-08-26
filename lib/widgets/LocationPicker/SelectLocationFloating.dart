import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:provider/provider.dart';

import '../../Screens/home.dart';
import '../../core/Providers/AddressProvider.dart';
import '../../features/location_service/data/model/address_model.dart';

class SetAddressFloatingButton extends StatefulWidget {
  final PickResult selectedPlace;
  final SearchingState state;
  final bool isSearchBarFocused;

  SetAddressFloatingButton({
    this.isSearchBarFocused,
    this.selectedPlace,
    this.state,
    Key key,
  }) : super(key: key);

  @override
  _SetAddressFloatingButtonState createState() =>
      _SetAddressFloatingButtonState();
}

class _SetAddressFloatingButtonState extends State<SetAddressFloatingButton> {
  final key = GlobalKey<FormState>();
  bool confirmLocation = false;
  String finalAddress;

  onbuttonClick(AddressProvider addressProvider) {
    if (!confirmLocation) {
      setState(() {
        confirmLocation = !confirmLocation;
      });
    } else {
      if (key.currentState.validate()) {
        key.currentState.save();
        AddressModel addressModel = AddressModel(
          formattedAddress: finalAddress,
          shortAddress: widget.selectedPlace.addressComponents[0].shortName,
          lat: widget.selectedPlace.geometry.location.lat,
          long: widget.selectedPlace.geometry.location.lng,
        );
        addressProvider.cacheCurrentAddress(addressModel);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      } else {
        setState(() {
          confirmLocation = !confirmLocation;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressProvider>(context);
    return FloatingCard(
      bottomPosition:
          32.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
      leftPosition: 16.0,
      rightPosition: 16.0,
      //width: 500,
      borderRadius: BorderRadius.circular(12.0),
      child: widget.state == SearchingState.Searching ||
              widget.selectedPlace == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  confirmLocation
                      ? Form(
                          key: key,
                          child: TextFormField(
                            onChanged: (value) => finalAddress = value,
                            onSaved: (newValue) => finalAddress = newValue,
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            initialValue:
                                widget.selectedPlace.formattedAddress ?? '',
                            validator: (value) => value.isEmpty
                                ? 'Address Cannot be empty'
                                : null,
                          ),
                        )
                      : Text(
                          widget.selectedPlace.formattedAddress ?? '',
                        ),
                  RaisedButton(
                    colorBrightness: Brightness.dark,
                    color: Colors.black,
                    child: Text(
                      confirmLocation ? "SELECT LOCATION" : "CONFIRM LOCATION",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => onbuttonClick(addressProvider),
                  ),
                ],
              ),
            ),
    );
  }
}
