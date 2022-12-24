class UserModel {
  late String userId , email , name, phoneNumber ;

  UserModel({required this.userId, required this.email, required this.name, required this.phoneNumber});

  UserModel.fromJson(Map<dynamic,dynamic> userMap){
  if (userMap==null){
    return;
}
  userId=userMap['userId'];
  email=userMap['email'];
  name=userMap['name'];
  phoneNumber=userMap['phoneNumber'];

}
  toJson(){
    return{
      'userId':userId,
      'email' :email,
      'name':name,
      'phoneNumber' :phoneNumber,

    };
  }
}