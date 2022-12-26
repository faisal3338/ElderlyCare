import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elderlycare/model/user_model.dart';

class FireStoreUser {
  final CollectionReference _userCokkectionRef =
      FirebaseFirestore.instance.collection('Users');

  Future<void> addUserToFireStore(UserModel userModel) async{
    return await _userCokkectionRef.doc(userModel.userId).set(userModel.toJson());
  }
}