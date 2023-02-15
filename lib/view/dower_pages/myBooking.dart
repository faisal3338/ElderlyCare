import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../view_model/appointment_view_model.dart';
import '../widgets/custom_button.dart';



class MyBooked extends GetWidget<AppointmentViewModel> {


  Future<void>? _launched;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
  //obx
  Widget build(BuildContext context) {
    final Uri toLaunch =
    Uri(scheme: 'https', host: 'www.cylog.org', path: 'headers/');
    return Obx(() {
      controller.loadMyAppointmentsData();
      return ( Scaffold(
        backgroundColor: Color.fromRGBO(175,176,200, 6),
        appBar: AppBar(
            title:  Center(child: Text('My Booked')),
            centerTitle: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: <Color>[Colors.purple, Colors.blue])),
            )
        ),

        body:ListView.builder(

            itemCount: controller.myAppointmentsList.length.toInt(),
            itemBuilder: (context, index) {
              return
                Column(
                  children: [
                    Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.0),
                        ),

                        // color:Color.fromRGBO(86,93,147,4),
                        shadowColor: Colors.blueGrey,
                        elevation: 10,
                        margin: const EdgeInsets.all(9),
                        borderOnForeground: true,

                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              onTap: (){
                               // Get.to(EndAppointment(index));
                              },
                              title: Text('Specialist name: ${controller.myAppointmentsList.value[index].specialist}',style: TextStyle(fontWeight: FontWeight.bold),),


                              subtitle: Text(
                                  'Date : ${  DateFormat('dd-MM').format( controller.myAppointmentsList.value[index].dateTime)}\n'
                                      'Time: ${  DateFormat('hh:mm').format( controller.myAppointmentsList.value[index].dateTime)}',),
                              // trailing: SizedBox(
                              //   width: 100,
                              //   child:
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [

                                const SizedBox(width: 8),
                                CustomButton(
                                  text: 'Call',
                                  color: Colors.green,
                                  onPressed: () {
                                     launch("tel:0${controller.myAppointmentsList.value[index].specialistNumber}");
                                  },
                                ),
                                SizedBox(width: 5,),
                                CustomButton(
                                  text: 'Cancel',
                                  color: Colors.red,
                                  onPressed: () {
                                      controller.cancelAppointment(controller.myAppointmentsList.value[index].appointmentId);
                                  },
                                ),
                                SizedBox(width: 5,)
                              ],
                            ),
                            SizedBox(height: 8,),
                            //    ),


                            //  ),
                          ],
                        )),

                  ],
                );


            }
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: (){
            controller.loadMyAppointmentsData();
          },
        ),
      )
      );
    });

  }

//obx
// @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Center(child: Text('Firebase Firestore')),
//         ),
//         body: StreamBuilder(
//           stream:controller.appointmentsRef.snapshots(),
//           builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
//             if (streamSnapshot.hasData) {
//               return ListView.builder(
//                 itemCount: streamSnapshot.data!.docs.length,
//                 itemBuilder: (context, index) {
//                   final DocumentSnapshot documentSnapshot =
//                   streamSnapshot.data!.docs[index];
//                   return Card(
//                     margin: const EdgeInsets.all(10),
//                     child: ListTile(
//                       title: Text(documentSnapshot['time']),
//                       subtitle: Text(documentSnapshot['doctor'].toString()),
//                       trailing: SizedBox(
//                         width: 100,
//
//                         child: Row(
//                           children: [
//                             IconButton(
//                                 icon: const Icon(Icons.edit),
//                                 onPressed: () =>
//                                     _update(documentSnapshot)),
//                             // IconButton(
//                                 // icon: const Icon(Icons.delete),
//                                 // onPressed: () =>
//                                     // _delete(documentSnapshot.id)),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }
//
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//         ),
// // Add new product
// //         floatingActionButton: FloatingActionButton(
// //           // onPressed: () => _create(),
// //           child: const Icon(Icons.add),
// //
// //         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
//     );
//   }
}

//open map helper
class MapUtils {

  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}