

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/appointments_model.dart';

class HistoryViewModel extends GetxController {


  RxList<AppointmentsModel> historyList= <AppointmentsModel>[].obs;

  void onInit(){

    super.onInit();
    loadHistoryData();
  }

  loadHistoryData()async{

    var historyData=await
    FirebaseFirestore.instance.collection('History')
        .where('hospital',isEqualTo: 'null')
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