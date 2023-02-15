import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:manger_app/model/specialist_model.dart';

import '../model/appointments_model.dart';


class AppointmentViewModel extends GetxController {


  late String  specialistID,specialist,time='';
  late DateTime dateTime;
  late double price=0;
  // var selectedDate = DateTime.now().obs;
  // var selectedTime = TimeOfDay.now().obs;
  TextEditingController textEditingController=TextEditingController();



  final userID = FirebaseAuth.instance.currentUser!.uid;

  RxList<AppointmentsModel> appointmentsList= <AppointmentsModel>[].obs;

  RxList<SpecialistModel> specialistList= <SpecialistModel>[].obs;


  final CollectionReference _appointmentDB =
  FirebaseFirestore.instance.collection('Appointments');

  final db = FirebaseFirestore.instance;



  void onInit(){

    super.onInit();
    deleteOlderAppointments();
   loadAppointmentsData();
  }

  loadAppointmentsData()async{

    var appointmentsData=await
    FirebaseFirestore.instance.collection('Appointments').orderBy('dateTime', descending: false).withConverter(
      fromFirestore: AppointmentsModel.fromFirestore,
      toFirestore: (AppointmentsModel appointmentsModel,options) =>appointmentsModel.toJson(),
    ).get();
    appointmentsList.clear();
    for(var doc in appointmentsData.docs){


      appointmentsList.add(doc.data());
      
    }
    
  }
  loadSpecialistsData()async{

    var specialistData=await
    FirebaseFirestore.instance.collection('Specialists').withConverter(
      fromFirestore: SpecialistModel.fromFirestore,
      toFirestore: (SpecialistModel specialistModel,options) =>specialistModel.toJson(),
    ).get();
    specialistList.clear();
    for(var doc in specialistData.docs){


      specialistList.add(doc.data());

    }

  }



  Future<void> bookAppointment(String appointmentID) {
    print(appointmentID);
    return _appointmentDB
        .doc(appointmentID)
        .update({'user': userID.toString()})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
  Future<void> setBookAppointment(String appointmentID) {
    print(appointmentID);
    return _appointmentDB
        .doc(appointmentID)
        .set({'user': userID.toString()},
      SetOptions(merge: true),
    )
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> deleteAppointment(String appointmentID) {
    return _appointmentDB
        .doc(appointmentID)
        .delete()
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));


  }



  Future<void> addAppointment(String specialistID,String specialist,String specialistNumber) {
    return _appointmentDB
        .add({

      'specialist': specialist,
      'dateTime': dateTime,
      'user': 'free',
      'price':price,
      'map1' :'null',
      'userId':'free',
      'specialistId' :specialistID,
      'map2' :'null',
      'hospital' :'null',
      'paidUp' :'null',
      'paymentMethod' :'null',
      'specialistNumber':specialistNumber,
      'userNumber':'null'

    })
        .then((value) =>
        _appointmentDB
        .doc(value.id)
        .set({'appointmentId': value.id},
      SetOptions(merge: true),
    )
    )
        .catchError((error) => print("Failed to add user: $error"));

  }


deleteOlderAppointments()async{
  // First, retrieve all documents that match the filter
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("Appointments")
      .where("dateTime", isLessThan: Timestamp.fromDate(DateTime.now().subtract(Duration(hours: 24)))).get();

// Next, iterate through the returned documents and delete them
  querySnapshot.docs.forEach((doc) async {
    await doc.reference.delete();
  });
}
updateAppointment(String specialistID,String specialist,String appointmentID,String specialistNumber){
  _appointmentDB
      .doc(appointmentID)
      .update({
    'specialist': specialist,
    'dateTime': dateTime,
    'price':price,
    'specialistId' :specialistID,
    'specialistNumber':specialistNumber,

  })
      .then((value) => print("User Updated"))
      .catchError((error) => print("Failed to update user: $error"));
}

  // void selectDate() async {
  //   final DateTime? pickedDate = await showDatePicker(
  //     context: Get.context!,
  //     initialDate: selectedDate.value,
  //     firstDate: DateTime(2018),
  //     lastDate: DateTime(2025),
  //   );
  //   if (pickedDate != null && pickedDate != selectedDate.value) {
  //     selectedDate.value = pickedDate;
  //     textEditingController.text=DateFormat('DD-MM-yyyy').format(selectedDate.value).toString();
  //     }
  //     }






}
