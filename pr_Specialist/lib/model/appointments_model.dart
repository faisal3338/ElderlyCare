import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentsModel {
  late String appointmentId ,  user, specialist,userId, specialistId ,map1,map2;
  late DateTime dateTime;
  late double price ;
  late String hospital,paidUp,paymentMethod;
  late String specialistNumber,userNumber;

  AppointmentsModel({required this.appointmentId, required this.dateTime, required this.user, required this.specialist,
    required this.map1,required this.userId, required this.specialistId,required this.map2,required this.price,
    required this.hospital, required this.paidUp, required this.paymentMethod,required this.specialistNumber, required this.userNumber
  });


  AppointmentsModel.fromJson(Map<dynamic,dynamic> appointmentMap){
    if (appointmentMap==null){
      return;
    }
    appointmentId=appointmentMap['appointmentId'];
    dateTime=appointmentMap['dateTime'];
    user=appointmentMap['user'];
    specialist=appointmentMap['specialist'];
    map1=appointmentMap['map1'];
    userId=appointmentMap['userId'];
    specialistId=appointmentMap['specialistId'];
    map2=appointmentMap['map2'];
    price=appointmentMap['price'];
    hospital=appointmentMap['hospital'];
    paidUp=appointmentMap['paidUp'];
    paymentMethod=appointmentMap['paymentMethod'];
    specialistNumber=appointmentMap['specialistNumber'];
    userNumber=appointmentMap['userNumber'];


  }
  factory AppointmentsModel.fromFirestore(
      DocumentSnapshot<Map<dynamic,dynamic>>snapshot,
      SnapshotOptions? options,
      ){
    final data=snapshot.data();
    return AppointmentsModel(
      appointmentId:data?['appointmentId'],
      dateTime:data?['dateTime'].toDate(),
      user:data?['user'],
      specialist:data?['specialist'],
      map1:data?['map1'],
      userId:data?['userId'],
      specialistId:data?['specialistId'],
      map2:data?['map2'],
      price:data?['price'],
      hospital:data?['hospital'],
      paidUp:data?['paidUp'],
      paymentMethod:data?['paymentMethod'],
      specialistNumber:data?['specialistNumber'],
      userNumber:data?['userNumber'],
    );
  }
  toJson(){
    return{
      'appointmentId':appointmentId,
      'dateTime' :dateTime,
      'user':user,
      'specialist' :specialist,
      'map1' :map1,
      'userId':userId,
      'specialistId' :specialistId,
      'map2' :map2,
      'price' :price,
      'hospital' :hospital,
      'paidUp' :paidUp,
      'paymentMethod' :paymentMethod,
      'specialistNumber' :specialistNumber,
      'userNumber' :userNumber,

    };
  }
}