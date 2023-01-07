import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentsModel {
  late String appointmentId , time , user, Specialist ;

  AppointmentsModel({required this.appointmentId, required this.time, required this.user, required this.Specialist});


  AppointmentsModel.fromJson(Map<dynamic,dynamic> appointmentMap){
    if (appointmentMap==null){
      return;
    }
    appointmentId=appointmentMap['appointmentId'];
    time=appointmentMap['time'];
    user=appointmentMap['user'];
    Specialist=appointmentMap['Specialist'];

  }
  factory AppointmentsModel.fromFirestore(
      DocumentSnapshot<Map<dynamic,dynamic>>snapshot,
      SnapshotOptions? options,
      ){
    final data=snapshot.data();
    return AppointmentsModel(
        appointmentId:data?['appointmentId'],
        time:data?['time'],
        user:data?['user'],
      Specialist:data?['Specialist'],
    );
  }
  toJson(){
    return{
      'appointmentId':appointmentId,
      'time' :time,
      'user':user,
      'Specialist' :Specialist,

    };
  }
}