import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/appointments_model.dart';

class AppointmentViewModel extends GetxController {


late String paidUp;

late double remainder;
  final userID = FirebaseAuth.instance.currentUser!.uid;
  RxList<AppointmentsModel> appointmentsList= <AppointmentsModel>[].obs;
  RxList<AppointmentsModel> appointmentsListFree= <AppointmentsModel>[].obs;
  final CollectionReference _appointmentDB =
  FirebaseFirestore.instance.collection('Appointments');

  final db = FirebaseFirestore.instance;

  void onInit(){

    super.onInit();
   loadAppointmentsData();
   loadAppointmentsDataFree();
  }

  loadAppointmentsData()async{

    var appointmentsData=await
    FirebaseFirestore.instance.collection('Appointments')
        .where('specialistId', isEqualTo: userID)
        .where('userId',isNotEqualTo: 'free')
        // .orderBy('dateTime', descending: false)
        .withConverter(
        fromFirestore:  AppointmentsModel.fromFirestore,
      toFirestore: (AppointmentsModel appointmentsModel,options) =>appointmentsModel.toJson(),
    ).get();
    appointmentsList.clear();
    for(var doc in appointmentsData.docs){


      appointmentsList.add(doc.data());

    }

  }
  loadAppointmentsDataFree()async{

    var appointmentsData=await
    FirebaseFirestore.instance.collection('Appointments')
        .where('specialistId', isEqualTo: userID)
        .where('userId',isEqualTo: 'free')
        .orderBy('dateTime', descending: false)
        .withConverter(
        fromFirestore:  AppointmentsModel.fromFirestore,
      toFirestore: (AppointmentsModel appointmentsModel,options) =>appointmentsModel.toJson(),
    ).get();
    appointmentsListFree.clear();
    for(var doc in appointmentsData.docs){


      appointmentsListFree.add(doc.data());

    }

  }



  Future<void> paidUpAppointment(String appointmentID) {


    return _appointmentDB
        .doc(appointmentID)
        .update({'paidUp': paidUp})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));




  }
  Future<void> history(int index) async {
    final CollectionReference _userCollectionRef =
    FirebaseFirestore.instance.collection('History');
     await _userCollectionRef.doc(appointmentsList[index].appointmentId).set(appointmentsList[index].toJson());

    return _appointmentDB
        .doc(appointmentsList[index].appointmentId)
        .delete();

  }
  Future<void>updataUserwallet(String userId,double price)async{
  remainder=double.parse(paidUp)-price;
  print('rrrrrrrrrrrrrrrrrr${remainder}');
  if(remainder<0){
    remainder=remainder.abs();
    FirebaseFirestore.instance.collection('Users')
        .doc(userId)
        .update({'wallet':FieldValue.increment(-remainder) });
  }
  else{
    FirebaseFirestore.instance.collection('Users')
        .doc(userId)
        .update({'wallet':FieldValue.increment(remainder) });
  }

  }


}
