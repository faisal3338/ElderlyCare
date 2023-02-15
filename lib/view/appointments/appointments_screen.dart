import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elderlycare/core/service/firestore_appointments.dart';
import 'package:elderlycare/view/widgets/custom_button.dart';
import 'package:elderlycare/view_model/appointment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../payment/checkout.dart';



class AppointmentScreen extends GetWidget<AppointmentViewModel> {


  final Text specialist=Text("Specialist Name", style: TextStyle(fontWeight: FontWeight.bold));
  //obx
  Widget build(BuildContext context) {
    return Obx(() {
      return ( Scaffold(
        backgroundColor: Color.fromRGBO(175,176,200, 6),
        appBar: AppBar(
            title: Text('Book Appointment'),
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
            padding: EdgeInsets.all(1),
            itemCount: controller.appointmentsList.length.toInt(),
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
                        margin: const EdgeInsets.all(10),
                        borderOnForeground: true,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('Specialist name: ${controller.appointmentsList.value[index].specialist}',
                                style: TextStyle(
                                  fontSize: 20.0,
                                    fontWeight: FontWeight.bold
                                 // color: Colors.white,
                                ),
                              ),
                              subtitle: Text(
                                'Date: ${  DateFormat('dd-MM').format( controller.appointmentsList.value[index].dateTime)}\n'
                                    'Time: ${  DateFormat('hh:mm').format( controller.appointmentsList.value[index].dateTime)}',
                                style: TextStyle(
                                //  color: Colors.white70,
                                ),
                              ),
              ),
                              // trailing: SizedBox(
                              //   width: 90,
                              //   height:70,
                              //   child:
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,

                                  children: [
                                    CustomButton(
                                      color: Color.fromRGBO(242,184,67,4),
                                      text: 'Book',

                                      onPressed: (){
                                        Get.to(Checkout(index));
                                        // controller.loadAppointmentsData();
                                      },
                                    ),
                                    SizedBox(width:15),
                                  ],
                                ),
                            //  ),
                           // ),
                            SizedBox(height:8 ,)
                          ],
                        )
                    ),

                  ],
                );


            }
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.refresh),
          onPressed: (){
            controller.loadAppointmentsData();
          },
        ),
      ));
    });

  }

}
