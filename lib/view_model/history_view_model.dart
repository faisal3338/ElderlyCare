

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/appointments_model.dart';

class HistoryViewModel extends GetxController {

  final userID = FirebaseAuth.instance.currentUser!.uid;
  RxList<AppointmentsModel> historyList= <AppointmentsModel>[].obs;

  void onInit(){

    super.onInit();
    loadHistoryData();
  }

  loadHistoryData()async{

    var historyData=await
    FirebaseFirestore.instance.collection('History')
        .where('userId',isEqualTo: userID)
        .orderBy('dateTime', descending: true)
        .withConverter(
      fromFirestore:  AppointmentsModel.fromFirestore,
      toFirestore: (AppointmentsModel appointmentsModel,options) =>appointmentsModel.toJson(),
    ).get();
    historyList.clear();
    for(var doc in historyData.docs){


      historyList.add(doc.data());

    }

  }

}