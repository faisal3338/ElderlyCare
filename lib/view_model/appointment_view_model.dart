import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elderlycare/model/appointments_model.dart';
import 'package:elderlycare/model/user_model.dart';
import 'package:elderlycare/view_model/auth_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentViewModel extends GetxController {





  final userID = FirebaseAuth.instance.currentUser!.uid;
  RxList<AppointmentsModel> appointmentsList= <AppointmentsModel>[].obs;
  final CollectionReference _appointmentDB =
  FirebaseFirestore.instance.collection('Appointments');

  final db = FirebaseFirestore.instance;

  void onInit(){

    super.onInit();
   loadAppointmentsData();
  }

  loadAppointmentsData()async{

    var appointmentsData=await
    FirebaseFirestore.instance.collection('Appointments').withConverter(
      fromFirestore: AppointmentsModel.fromFirestore,
      toFirestore: (AppointmentsModel appointmentsModel,options) =>appointmentsModel.toJson(),
    ).get();
    appointmentsList.clear();
    for(var doc in appointmentsData.docs){


      appointmentsList.add(doc.data());
      
    }
    
  }



  Future<void> bookAppointment(String appointmnetID) {
    return _appointmentDB
        .doc(appointmnetID)
        .update({'user': userID.toString()})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }






}
