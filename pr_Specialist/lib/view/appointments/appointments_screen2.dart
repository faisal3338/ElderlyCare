import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


import '../../view_model/appointment_view_model.dart';
import '../widgets/custom_button.dart';



class AppointmentScreen2 extends GetWidget<AppointmentViewModel> {




  //
  //obx
  Widget build(BuildContext context) {

    return Obx(() {
      controller.loadAppointmentsData();
      return ( Scaffold(
        backgroundColor: Color.fromRGBO(175,176,200, 6),
        appBar: AppBar(
          title:  Text('Appointment'),
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

            itemCount: controller.appointmentsListFree.length.toInt(),
            itemBuilder: (context, index) {
              return
                Column(
                  children: [
                    Card(
                        borderOnForeground: true,
                        elevation: 10,
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: Text('State: ${controller.appointmentsListFree.value[index].user}',style: TextStyle(fontWeight: FontWeight.bold)),

                              subtitle: Text(
                                  'Date: ${  DateFormat('dd-MM').format( controller.appointmentsListFree.value[index].dateTime)}\n'
                                      'Time: ${  DateFormat('hh:mm').format( controller.appointmentsListFree.value[index].dateTime)}'
                              ),
                ),
                              // trailing: SizedBox(
                              //   width: 100,
                              //   child:
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // CustomButton(
                                    //   text: 'Location',
                                    //   color: Color.fromRGBO(242,184,67,4),
                                    //   onPressed: (){
                                    //     _launched = _launchInBrowser(toLaunch);
                                    //     MapUtils.openMap(double.parse( controller.appointmentsList.value[index].map1),double.parse( controller.appointmentsList.value[index].map2));
                                    //  //   Get.to(Test(index: index1);
                                    //     // AppointmentViewModel.openMap(double.parse( controller.appointmentsList.value[index].map1),double.parse( controller.appointmentsList.value[index].map2));
                                    //     controller.loadAppointmentsData();
                                    //   },
                                    //  // color: Colors.red,
                                    // ),
                                    // const SizedBox(width: 8),
                                    // TextButton(
                                    //   child: const Text('Call'),
                                    //   onPressed: () {/* ... */},
                                    // ),
                                  ],
                                ),
                              // ),
                            // ),
                            SizedBox(height: 8,)
                          ],
                        ),

                    ),
                    ],
                  );
            }
            ),
          // floatingActionButton: FloatingActionButton(
          //   child: Icon(Icons.refresh),
          //   onPressed: (){
          //     controller.loadAppointmentsData();
          //   },
          // ),
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
