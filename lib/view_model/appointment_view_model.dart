import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elderlycare/model/appointments_model.dart';
import 'package:elderlycare/model/user_model.dart';
import 'package:elderlycare/view_model/auth_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentViewModel extends GetxController {


  late String map1,map2;

  final userID = FirebaseAuth.instance.currentUser!.uid;
  String name=' ';

  String paymentMethod='cash';
  RxList<AppointmentsModel> appointmentsList= <AppointmentsModel>[].obs;
  RxList<AppointmentsModel> myAppointmentsList= <AppointmentsModel>[].obs;
  final CollectionReference _appointmentDB =
  FirebaseFirestore.instance.collection('Appointments');

  final db = FirebaseFirestore.instance;


  DocumentSnapshot<Map<String, dynamic>>? userInfo ;


  void onInit()async{

    super.onInit();
    loadAppointmentsData();
    loadMyAppointmentsData();
    userInfo = await FirebaseFirestore.instance
        .collection('Users').doc(userID)
        .get();

// name=userInfo?[name];
    // await FirebaseFirestore.instance
    //     .collection('Users').doc(userID)
    //     .set({
    //   'wallet':0
    // },
    //   SetOptions(merge: true),);

  }

  loadAppointmentsData()async{

    var appointmentsData=await
    FirebaseFirestore.instance.collection('Appointments')
        .where('userId', isEqualTo: 'free')
        .orderBy('dateTime', descending: false)
        .withConverter(
      fromFirestore:  AppointmentsModel.fromFirestore,
      toFirestore: (AppointmentsModel appointmentsModel,options) =>appointmentsModel.toJson(),
    ).get();
    appointmentsList.clear();
    for(var doc in appointmentsData.docs){


      appointmentsList.add(doc.data());

    }

  }

  loadMyAppointmentsData()async{

    var appointmentsData=await
    FirebaseFirestore.instance.collection('Appointments')
        .where('userId', isEqualTo: userID)
        .orderBy('dateTime', descending: false)
        .withConverter(
      fromFirestore:  AppointmentsModel.fromFirestore,
      toFirestore: (AppointmentsModel appointmentsModel,options) =>appointmentsModel.toJson(),
    ).get();
    myAppointmentsList.clear();
    for(var doc in appointmentsData.docs){


      myAppointmentsList.add(doc.data());

    }

  }



  Future<void> bookAppointmentByCash(String appointmnetID,double price) async{

    final DocumentSnapshot<Map<String, dynamic>> userInfo = await FirebaseFirestore.instance
        .collection('Users').doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    num paidUp=price-userInfo['wallet'];
    if(paidUp<=0){
      paidUp=price;
      FirebaseFirestore.instance.collection('Users')
          .doc(userID)
          .update({'wallet':FieldValue.increment(-price) });
    
    }
    else if(userInfo['wallet']<0){
      paidUp=0;
    }
    else{
      paidUp=userInfo['wallet'];
      FirebaseFirestore.instance.collection('Users')
          .doc(userID)
          .update({'wallet':FieldValue.increment(-paidUp) });

    }

    return _appointmentDB
        .doc(appointmnetID)
        .update({
      'userId': userID.toString(),
      'user': userInfo['name'],
      'map1':map1,
      'map2':map2,
      'paidUp':paidUp.toString(),
      'paymentMethod':paymentMethod,
      'userNumber':userInfo['phoneNumber']
    })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
  Future<void> bookAppointmentByCard(String appointmnetID,String paidUp) async{

    final DocumentSnapshot<Map<String, dynamic>> userInfo = await FirebaseFirestore.instance
        .collection('Users').doc(FirebaseAuth.instance.currentUser!.uid)
        .get();


    return _appointmentDB
        .doc(appointmnetID)
        .update({
      'userId': userID.toString(),
      'user': userInfo['name'],
      'map1':map1,
      'map2':map2,
      'paidUp':paidUp,
      'paymentMethod':paymentMethod,
      'userNumber':userInfo['phoneNumber']
    })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> bookAppointmentByInstallment(String appointmnetID,String paidUp) async{

    final DocumentSnapshot<Map<String, dynamic>> userInfo = await FirebaseFirestore.instance
        .collection('Users').doc(FirebaseAuth.instance.currentUser!.uid)
        .get();


    return _appointmentDB
        .doc(appointmnetID)
        .update({
      'userId': userID.toString(),
      'user': userInfo['name'],
      'map1':map1,
      'map2':map2,
      'paidUp':paidUp,
      'paymentMethod':paymentMethod,
      'userNumber':userInfo['phoneNumber']
    })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
  Future<void>updataUserwallet(double price)async{

    FirebaseFirestore.instance.collection('Users')
        .doc(userID)
        .update({'wallet':FieldValue.increment(-price) });
  }
  
  
  Future<void> cancelAppointment(String appointmnetID) async{

    final DocumentSnapshot<Map<String, dynamic>> appointmentInfo =await
    FirebaseFirestore.instance.collection('Appointments')
    .doc(appointmnetID)
        .get();

    String moneyBack=appointmentInfo['paidUp'];
    
    FirebaseFirestore.instance.collection('Users')
        .doc(userID)
        .update({'wallet':FieldValue.increment(double.parse(moneyBack))});

    return _appointmentDB
        .doc(appointmnetID)
        .update({
      'userId': 'free',
      'user': 'free',
      'map1':'null',
      'map2':'null',
      'paidUp':'0',
      'paymentMethod':'null',
      'userNumber':'null'
    })
        .then((value) => loadAppointmentsData())
        .catchError((error) => print("Failed to update user: $error"));
  }

  chargeWallet(double amount)async{
    await FirebaseFirestore.instance
        .collection('Users').doc(userID)
        .update({
      'wallet':FieldValue.increment(amount)
    },
    );
  }










}
