import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentsModel {
  late String appointmentId , time , user, specialist ;

  AppointmentsModel({required this.appointmentId, required this.time, required this.user, required this.specialist});


  AppointmentsModel.fromJson(Map<dynamic,dynamic> appointmentMap){
    if (appointmentMap==null){
      return;
    }
    appointmentId=appointmentMap['appointmentId'];
    time=appointmentMap['time'];
    user=appointmentMap['user'];
    specialist=appointmentMap['specialist'];

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
      specialist:data?['specialist'],
    );
  }
  toJson(){
    return{
      'appointmentId':appointmentId,
      'time' :time,
      'user':user,
      'specialist' :specialist,

    };
  }
}