import 'package:elderlycare/payment/e_wallet.dart';
import 'package:elderlycare/payment/instalment_payment.dart';
import 'package:elderlycare/payment/remove_card.dart';
import 'package:elderlycare/view/appointments/appointments_screen.dart';
import 'package:elderlycare/view/dower_pages/history.dart';
import 'package:elderlycare/view_model/appointment_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:elderlycare/payment/my_card_payment.dart';
import 'package:google_maps_place_picker_mb/src/google_map_place_picker.dart';
import 'dart:io' show Platform;

// Your api key storage.
import '../../view_model/card_payment_view_model.dart';
import '../auth/login_phone_number.dart';
import '../dower_pages/myBooking.dart';

import '../widgets/custom_button.dart';
import 'keys.dart';

// Only to control hybrid composition and the renderer in Android
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';



// class MapPage extends StatefulWidget {
//   MapPage({Key? key}) : super(key: key);
//   @override
//   _MapPageState createState() => _MapPageState();
// }
FirebaseAuth _auth =FirebaseAuth.instance;
class MapPageState extends GetWidget<AppointmentViewModel> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  // final userInfo = Get.put(AuthViewModel());

//================
  static final kInitialPosition = LatLng(21.574748,39.225283);

  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;



  PickResult? selectedPlace;
  bool _showPlacePickerInContainer = false;
  bool _showGoogleMapInContainer = false;

  @override
  Widget build(BuildContext context) {
    final cardController = Get.put(CardPaymentViewModel());
    controller.onInit();

    return Scaffold(
      // drawer:  Drawer(),
        key: scaffoldKey,
        drawer: Drawer(
          //
          backgroundColor: Color.fromRGBO(175,176,200, 6),
          //
          child: ListView(
            padding: EdgeInsets.zero,
            children:  [
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    CircleAvatar(
                      backgroundImage: ExactAssetImage('assets/images/user.png'),
                      radius: 45,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(controller.name),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.payment),
                title: Text('Payment Cards'),
                onTap: () => Get.to(MyCardPayment()),
              ),
              ListTile(
                leading: Icon(Icons.wallet),
                title: Text('E wallet'),
                onTap: () => Get.to(E_Wallet()),
              ),
              ListTile(
                leading: Icon(Icons.book_rounded),
                title: Text('My booked'),
                onTap: () => Get.to(MyBooked()),
              ),
              ListTile(
                leading: Icon(Icons.history),
                title: Text('History'),
                onTap: () => Get.to(History()),
              ),


              SizedBox(height: 120,),

              Container(
                  margin: EdgeInsets.all(70),
                  height: 50,
                  width: 50,
                  child: ElevatedButton.icon(
                      style: ButtonStyle(
                        // padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                        elevation: MaterialStateProperty.all(8),
                        // shape: MaterialStateProperty.all(
                        //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        shadowColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.onSurface),
                      ),
                      icon: Icon(Icons.logout),
                      label: Text("Logout"),
                      onPressed: (){
                        _auth.signOut();
                        Get.offAll(LoginPhoneNumber());
                      }
                  )
              )
            ],
          ),
        ),
        body: Center(
          child: PlacePicker(
            resizeToAvoidBottomInset:
            false, // only works in page mode, less flickery
            apiKey: Platform.isAndroid
                ? APIKeys.androidApiKey
                : APIKeys.iosApiKey,
            hintText: "Find a place ...",
            searchingText: "Please wait ...",
            selectText: "Select place",
            outsideOfPickAreaText: "Place not in area",
            initialPosition: kInitialPosition,
            useCurrentLocation: true,
            selectInitialPosition: true,
            usePinPointingSearch: true,
            usePlaceDetailSearch: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            onTapBack: () => scaffoldKey.currentState?.openDrawer(),
            onMapCreated: (GoogleMapController controller) {
              print("Map created");
            },
            onPlacePicked: (PickResult result) {
              print(
                  "Place picked: ${result.formattedAddress}");

              selectedPlace = result;
              print("(lat is:  " +
                  selectedPlace!.geometry!.location.lat.toString() +
                  ", lng is: " +
                  selectedPlace!.geometry!.location.lng.toString() +
                  ")");
              controller.map1=selectedPlace!.geometry!.location.lat.toString();
              controller.map2=selectedPlace!.geometry!.location.lng.toString();
              print("(lat is:  " +
                  controller.map1+
                  ", lng is: " +
                  controller.map2 +
                  ")");

              Get.to(AppointmentScreen());

            },
            onMapTypeChanged: (MapType mapType) {
              print(
                  "Map type changed to ${mapType.toString()}");
            },
          ),
          // child: Column(
          //   children: <Widget>[
          //     ElevatedButton(
          //       child: Text("Load Place Picker"),
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) {
          //               return
          //
          //             },
          //           ),
          //         );
          //       },
          //     ),
          //
          //     if (selectedPlace != null) ...[
          //
          //       Text(selectedPlace!.formattedAddress!),
          //       Text("(lat: " +
          //           selectedPlace!.geometry!.location.lat.toString() +
          //           ", lng: " +
          //           selectedPlace!.geometry!.location.lng.toString() +
          //           ")"),
          //
          //     ],
          //
          //     !_showGoogleMapInContainer ? Container() : const TextField(),
          //
          //     // #endregion
          //   ],
          //
          // ),

        ));
  }
}
//class

