class UserModel {
  late String userId  , name, phoneNumber ;

  UserModel({required this.userId, required this.name, required this.phoneNumber});


  UserModel.fromJson(Map<dynamic,dynamic> userMap){
  if (userMap==null){
    return;
}
  userId=userMap['userId'];
  name=userMap['name'];
  phoneNumber=userMap['phoneNumber'];

}
  toJson(){
    return{
      'userId':userId,
      'name':name,
      'phoneNumber' :phoneNumber,

    };
  }
}