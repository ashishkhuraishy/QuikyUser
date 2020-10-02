import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:provider/provider.dart';
import 'package:quiky_user/Screens/home.dart';
import 'package:quiky_user/core/Providers/AddressProvider.dart';
import 'package:quiky_user/features/location_service/domain/entity/address.dart';
import 'package:quiky_user/theme/themedata.dart';

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
  String flatno = '', landMark = '';

  onbuttonClick(AddressProvider addressProvider) {
    if (!confirmLocation) {
      setState(() {
        confirmLocation = !confirmLocation;
      });
    } else {
      if (key.currentState.validate()) {
        key.currentState.save();
        finalAddress =
            '${widget.selectedPlace.formattedAddress}, House / Flat No: $flatno, LandMark: $landMark ';
        Address addressModel = Address(
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
          0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
      leftPosition: 0,
      rightPosition: 0,
      //width: 500,
      borderRadius: BorderRadius.circular(12.0),
      child: widget.state == SearchingState.Searching ||
              widget.selectedPlace == null
          ? Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(child: CircularProgressIndicator()),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: confirmLocation
                      ? Column(
                        children: [
                          Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:15,right: 15,bottom: 15),
                            child: Text("Enter address details",style: Theme.of(context).textTheme.headline5,),
                          ),
                          Text("Your Location",style: Theme.of(context).textTheme.subtitle1,),
                          Row(
                            children: [
                              Icon(Icons.location_on,color: primary,),
                              Container(
                                padding: EdgeInsets.symmetric(vertical:5),
                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width-100
                                ),
                                child: Text(
                                    widget.selectedPlace.formattedAddress ?? '',
                                    style: Theme.of(context).textTheme.headline6,
                                    maxLines: 5,
                                  ),
                              ),
                            ],
                          ),
                        ],
                      ),
                          Form(
                              key: key,
                              child: Column(
                                children: [
                                  // TextFormField(
                                  //   onChanged: (value) => finalAddress = value,
                                  //   onSaved: (newValue) => finalAddress = newValue,
                                  //   textAlign: TextAlign.left,
                                  //   maxLines: 3,
                                  //   initialValue:
                                  //       widget.selectedPlace.formattedAddress ?? '',
                                  //   validator: (value) => value.isEmpty
                                  //       ? 'Address Cannot be empty'
                                  //       : null,
                                  //   style: Theme.of(context).textTheme.bodyText2,
                                  //   decoration: underlined(hint: "Address:"),
                                  // ),
                                  TextFormField(
                                      onChanged: (value) => flatno = value,
                                      onSaved: (newValue) => flatno = newValue,
                                      maxLines: 1,
                                      style: Theme.of(context).textTheme.bodyText2,
                                      decoration:
                                          underlined(hint: "House / Flat No:")),
                                  TextFormField(
                                      onChanged: (value) => landMark = value,
                                      onSaved: (newValue) => landMark = newValue,
                                      maxLines: 1,
                                      style: Theme.of(context).textTheme.bodyText2,
                                      decoration: underlined(hint: "Land Mark:")),
                                ],
                              ),
                            ),
                        ],
                      )
                      : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:15,right: 15,bottom: 15),
                            child: Text("Select Delivery Location",style: Theme.of(context).textTheme.headline5,),
                          ),
                          Text("Your Location",style: Theme.of(context).textTheme.subtitle1,),
                          Row(
                            children: [
                              Icon(Icons.location_on,color: primary,),
                              Container(
                                padding: EdgeInsets.symmetric(vertical:5),
                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width-100
                                ),
                                child: Text(
                                    widget.selectedPlace.formattedAddress ?? '',
                                    style: Theme.of(context).textTheme.headline6,
                                    maxLines: 5,
                                  ),
                              ),
                            ],
                          ),
                        ],
                      ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    colorBrightness: Brightness.dark,
                    color: primary,
                    child: Text(
                      confirmLocation ? "SAVE ADDRESS" : "Confirm Location & Proceed",
                      style: whiteBold14,
                    ),
                    padding: EdgeInsets.all(15),
                    onPressed: () => onbuttonClick(addressProvider),
                  ),
                ),
              ],
            ),
    );
  }
}
