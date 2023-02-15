import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elderlycare/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreUser {
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('Users');

  Future<void> addUserToFireStore(UserModel userModel) async{
     await _userCollectionRef.doc(userModel.userId).set(userModel.toJson(),
        SetOptions(merge: true),);

     final userRef = FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid);

     userRef.get().then((snapshot) {
       if (!snapshot.exists) {
         userRef.set({
           "wallet": 0
         });
       } else {
         if (!snapshot.data()!.containsKey("wallet")) {
           userRef.update({
             "wallet": 0
           });
         } else {
           print("e wallet already exists");
         }
       }
     });
  }
}