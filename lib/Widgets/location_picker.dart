import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:quiky_user/Constants/Apikeys.dart';
import 'package:quiky_user/Screens/selectlocation.dart';

import 'SelectLocationFloating.dart';

class LoctionPicker extends StatefulWidget {
  const LoctionPicker({
    Key key,
  }) : super(key: key);

  @override
  _LoctionPickerState createState() => _LoctionPickerState();
}

class _LoctionPickerState extends State<LoctionPicker> {
  PickResult selectedPlace;
  @override
  Widget build(BuildContext context) {
    return PlacePicker(
      apiKey: MapApiKey,
      initialPosition: SelectLocation.kInitialPosition,
      useCurrentLocation: true,
      automaticallyImplyAppBarLeading: false,
      selectInitialPosition: true,
      selectedPlaceWidgetBuilder:
          (_, selectedPlace, state, isSearchBarFocused) {
        print("state: $state, isSearchBarFocused: $isSearchBarFocused");
        return isSearchBarFocused
            ? Container()
            : SetAddressFloatingButton(
                selectedPlace: selectedPlace,
                state: state,
                isSearchBarFocused: isSearchBarFocused,
              );
      },
      //usePlaceDetailSearch: true,
      //forceSearchOnZoomChanged: true,
      //autocompleteLanguage: "ko",
      //region: 'au',
      // pinBuilder: (context, state) {
      //   if (state == PinState.Idle) {
      //     return Icon(Icons.favorite_border);
      //   } else {
      //     return Icon(Icons.favorite);
      //   }
      // },
    );
  }
}
