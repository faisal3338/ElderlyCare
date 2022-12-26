import 'package:flutter/material.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:google_maps_place_picker_mb/src/google_map_place_picker.dart';
import 'dart:io' show Platform;

// Your api key storage.
import 'keys.dart';

// Only to control hybrid composition and the renderer in Android
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';



class MapPage extends StatefulWidget {
  MapPage({Key? key}) : super(key: key);

  static final kInitialPosition = LatLng(21.574748,39.225283);

  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  PickResult? selectedPlace;
  bool _showPlacePickerInContainer = false;
  bool _showGoogleMapInContainer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xF2262254),
        appBar: AppBar(
          backgroundColor: Color(0xF2262254),
          title: Text("Google Map Place Picker"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              !_showPlacePickerInContainer
                  ? ElevatedButton(
                child: Text("Load Place Picker"),
                onPressed: () {
                  // initRenderer();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PlacePicker(
                          resizeToAvoidBottomInset:
                          false, // only works in page mode, less flickery
                          apiKey: Platform.isAndroid
                              ? APIKeys.androidApiKey
                              : APIKeys.iosApiKey,
                          hintText: "Find a place ...",
                          searchingText: "Please wait ...",
                          selectText: "Select place",
                          outsideOfPickAreaText: "Place not in area",
                          initialPosition: MapPage.kInitialPosition,
                          useCurrentLocation: true,
                          selectInitialPosition: true,
                          usePinPointingSearch: true,
                          usePlaceDetailSearch: true,
                          zoomGesturesEnabled: true,
                          zoomControlsEnabled: true,
                          onMapCreated: (GoogleMapController controller) {
                            print("Map created");
                          },
                          onPlacePicked: (PickResult result) {
                            print(
                                "Place picked: ${result.formattedAddress}");
                            setState(() {
                              selectedPlace = result;
                              Navigator.of(context).pop();
                            });
                          },
                          onMapTypeChanged: (MapType mapType) {
                            print(
                                "Map type changed to ${mapType.toString()}");
                          },
                        );
                      },
                    ),
                  );
                },
              )
                  : Container(),
              if (selectedPlace != null) ...[
                Text(selectedPlace!.formattedAddress!),
                Text("(lat: " +
                    selectedPlace!.geometry!.location.lat.toString() +
                    ", lng: " +
                    selectedPlace!.geometry!.location.lng.toString() +
                    ")"),
              ],
              !_showGoogleMapInContainer ? Container() : const TextField(),
              // #endregion
            ],
          ),
        ));
  }
}