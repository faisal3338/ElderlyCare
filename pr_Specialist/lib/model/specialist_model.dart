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
  toJson(){
    return{
      'specialistId':specialistId,
      'name':name,
      'phoneNumber' :phoneNumber,

    };
  }
}