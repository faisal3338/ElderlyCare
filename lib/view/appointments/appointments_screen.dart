import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elderlycare/core/service/firestore_appointments.dart';
import 'package:elderlycare/view_model/appointment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class AppointmentScreen extends GetWidget<AppointmentViewModel> {







//----------------------------------------
    // await showModalBottomSheet(
    //     isScrollControlled: true,
    //     context: context,
    //     builder: (BuildContext ctx) {
    //       return Padding(
    //         padding: EdgeInsets.only(
    //             top: 20,
    //             left: 20,
    //             right: 20,
    //             bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             TextField(
    //               controller: _nameController,
    //               decoration: const InputDecoration(labelText: 'Name'),
    //             ),
    //             TextField(
    //               keyboardType:
    //               const TextInputType.numberWithOptions(decimal: true),
    //               controller: _priceController,
    //               decoration: const InputDecoration(
    //                 labelText: 'Price',
    //               ),
    //             ),
    //             const SizedBox(
    //               height: 20,
    //             ),
    //             ElevatedButton(
    //               child: const Text( 'Update'),
    //               onPressed: () async {
    //                 final String name = _nameController.text;
    //                 final String price =_priceController.text;
    //
    //                 if (price != null) {
    //
    //                   await _products
    //                       .doc(documentSnapshot!.id)
    //                       .update({"name": name, "email": price});
    //                   _nameController.text = '';
    //                   _priceController.text = '';
    //                   Navigator.of(context).pop();
    //                 }
    //               },
    //             )
    //           ],
    //         ),
    //       );
    //     });


  //
  // Future<void> _delete(String productId) async {
  //   await _products.doc(productId).delete();
  //
  //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text('You have successfully deleted a product')));
  // }

  //obx
  Widget build(BuildContext context) {
    return Obx(() {
      return ( Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Book appointment')),
        ),
        body:ListView.builder(
            itemCount: controller.appointmentsList.length.toInt(),
            itemBuilder: (context, index) {
              return
                  Column(
                    children: [
                      Card(
                          // margin: const EdgeInsets.all(10),
                          child: ListTile(
                            title: Text(controller.appointmentsList.value[index].time),
                            subtitle: Text(
                                controller.appointmentsList.value[index].Specialist),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                    MaterialButton( onPressed: (){
                                    controller.appointmentsList.value[index].time='125';
                                    controller.bookAppointment(controller.appointmentsList.value[index].appointmentId);
                                    },color: Colors.green,
                                      child: Text('BOOk'),
                                      textColor: Colors.white,




                                    )
                                ],
                              ),
                            ),

                          )),

                    ],
                  );


            }
            ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              controller.loadAppointmentsData();
            },
          ),
      ));
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
