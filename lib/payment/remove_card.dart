import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elderlycare/view_model/card_payment_view_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../view_model/appointment_view_model.dart';
import '../view/widgets/custom_button.dart';
import 'my_card_payment.dart';




class RemoveCard extends GetWidget<CardPaymentViewModel> {



  //obx
  Widget build(BuildContext context) {

    return Obx(() {

      return ( Scaffold(
        backgroundColor: Color.fromRGBO(175,176,200, 6),
        appBar: AppBar(
            title:  Center(child: Text('Remove Card')),
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

            itemCount: controller.myCardList.length.toInt(),
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
                        margin:  EdgeInsets.all(9),
                        borderOnForeground: true,

                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            ListTile(
                              onTap: (){
                                // Get.to(EndAppointment(index));
                              },
                              title: Text(' ${controller.myCardList.value[index].cardNumber}',style: TextStyle(fontWeight: FontWeight.bold),),



                              // trailing: SizedBox(
                              //   width: 100,
                              //   child:
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [


                                SizedBox(width: 5,),
                                CustomButton(
                                  text: 'Remove',
                                  color: Colors.red,
                                  onPressed: () {
                                    controller.myCardList.remove(controller.myCardList.value[index]);
                                    print(controller.myCardList.length);
                                    controller.removeCard();
                                    controller.cardSelected=null;
                                    Get.off(MyCardPayment());

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