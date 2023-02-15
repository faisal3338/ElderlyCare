import 'package:cloud_firestore/cloud_firestore.dart';

class SpecialistModel {
  late String specialistId  , name, phoneNumber ;

  SpecialistModel({required this.specialistId, required this.name, required this.phoneNumber});


  SpecialistModel.fromJson(Map<dynamic,dynamic> specialistMap){
  if (specialistMap==null){
    return;
}
  specialistId=specialistMap['specialistId'];
  name=specialistMap['name'];
  phoneNumber=specialistMap['phoneNumber'];

}

  factory SpecialistModel.fromFirestore(
      DocumentSnapshot<Map<dynamic,dynamic>>snapshot,
      SnapshotOptions? options,
      ){
    final data=snapshot.data();
    return SpecialistModel(
      specialistId:data?['specialistId'],
      name:data?['name'],
      phoneNumber:data?['phoneNumber'],
    );
  }

  toJson(){
    return{
      'specialistId':specialistId,
      'name':name,
      'phoneNumber' :phoneNumber,

    };
  }
}