class MangerModel {
  late String mangerId  , name, phoneNumber ;

  MangerModel({required this.mangerId, required this.name, required this.phoneNumber});


  MangerModel.fromJson(Map<dynamic,dynamic> mangerMap){
  if (mangerMap==null){
    return;
}
  mangerId=mangerMap['mangerId'];
  name=mangerMap['name'];
  phoneNumber=mangerMap['phoneNumber'];

}
  toJson(){
    return{
      'mangerId':mangerId,
      'name':name,
      'phoneNumber' :phoneNumber,

    };
  }
}