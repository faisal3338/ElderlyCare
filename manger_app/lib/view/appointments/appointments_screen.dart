import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:manger_app/view/appointments/add_appointment_screen.dart';
import 'package:manger_app/view/appointments/edit_appointmnet_screen.dart';

import '../../view_model/appointment_view_model.dart';
import '../auth/login_phone_number.dart';
import '../widgets/custom_button.dart';


FirebaseAuth _auth =FirebaseAuth.instance;
class AppointmentScreen extends GetWidget<AppointmentViewModel> {







  Widget build(BuildContext context) {

    return Obx(() {
      controller.loadAppointmentsData();
      return ( Scaffold(
        backgroundColor: Color.fromRGBO(175,176,200, 6),
        appBar: AppBar(
          title: const Center(child: Text('Book appointment')),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                     // colors: <Color>[Color.fromRGBO(86,93,147,4), Color.fromRGBO(175,176,200, 6)])),
                    colors: <Color>[Colors.purple, Colors.blue])),
            ),actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  _auth.signOut();
                  Get.offAll(LoginPhoneNumber());
                },
                child: Icon(
                  Icons.logout,
                  size: 26.0,
                ),
              )
          ),
        ],
        ),

        body:ListView.builder(

            itemCount: controller.appointmentsList.length.toInt(),
            itemBuilder: (context, index) {
              return Column(
                    children: [
                      Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13.0),
                          ),

                          // color:Color.fromRGBO(86,93,147,4),
                          shadowColor: Colors.blueGrey,
                          elevation: 10,
                          margin: const EdgeInsets.all(10),
                          borderOnForeground: true,

                          child: Column(
                            children: [
                              ListTile(
                                title: Text('Specialist name: ${controller.appointmentsList.value[index].specialist}',style: TextStyle(fontWeight: FontWeight.bold)),

                                subtitle: Text(
                                    'Date: ${  DateFormat('dd-MM').format( controller.appointmentsList.value[index].dateTime)}\n'
                                        'Time: ${  DateFormat('hh:mm').format( controller.appointmentsList.value[index].dateTime)}',),
                                    // 'DateTime : ${  DateFormat('dd-MM \n  hh:mm').format( controller.appointmentsList.value[index].dateTime)}'),
                                // trailing: SizedBox(
                                //   width: 100,
                                //  child:
              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CustomButton(
                                    text: 'Edit',
                                    onPressed: (){

                                      Get.to(EditAppointmentScreen(index));
                                    },
                                    color: Colors.blueAccent,
                                  ),
                                  SizedBox(width: 8,),

                                  CustomButton(
                                    text: 'Delete',
                                    onPressed: (){
                                      controller.deleteAppointment(controller.appointmentsList.value[index].appointmentId);
                                      controller.loadAppointmentsData();
                                    },
                                    color: Colors.red,
                                  ),
                                  SizedBox(width: 8)
                                  ,
                                ],
                              ),
                              SizedBox(height: 8,)
                            ],
                          ),

                       //     ),

                          ),

                    ],
                  );
            }
            ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blueAccent,
            child: Icon(Icons.add),
            onPressed: (){
              Get.to(AddAppointmentScreen());

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
