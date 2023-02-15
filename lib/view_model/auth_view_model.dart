
import 'package:elderlycare/core/service/firestore_user.dart';
import 'package:elderlycare/view/auth/login_phone_number.dart';
import 'package:elderlycare/view/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/user_model.dart';
import '../view/map/maps.dart';

class AuthViewModel extends GetxController {
  GoogleSignIn _googleSignIn=GoogleSignIn(scopes: ['email']);
  FirebaseAuth _auth = FirebaseAuth.instance;


  late String email , password , name , phoneNumber;

  late var verificationId ='';
  late var otp='';
  Rxn<User> _user= Rxn<User>();

  String? get user =>_user.value?.email;

  void onInit(){

    super.onInit();
    _user.bindStream(_auth.authStateChanges());
  }





  void signInWithPhoneNumber() async{
    print(phoneNumber);
   await _auth.verifyPhoneNumber(
     phoneNumber: '+966${phoneNumber}',
       verificationCompleted: (AuthCredential authCredential) async{
       await _auth.signInWithCredential(authCredential);

       if (authCredential != null) {
          saveUserA(authCredential);
         Get.offAll(MapPageState());
       }
       },

       verificationFailed: (authException) {
    Get.snackbar("sms code info", "otp code hasn't been sent!!");

       },
       codeSent: (String verificationId, int? resendToken) {
       this.verificationId=verificationId;
       },
       codeAutoRetrievalTimeout: (verificationId) {
       this.verificationId=verificationId;
       }
       ,);

  }
   verifyOTP(String OTP)async {
print(verificationId);
    try {

      UserCredential credential =
      await _auth.signInWithCredential(PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: OTP
      ));

      if (credential.user != null) {
        saveUser(credential);
        Get.offAll(MapPageState());
      }
    } on Exception catch (e) {
      Get.snackbar("otp info", "otp code is not correct !!");
    }
  }

  void saveUser(UserCredential userCredential) async{
    await FireStoreUser().addUserToFireStore(UserModel(
      userId :userCredential.user!.uid,
      name: name,
      phoneNumber: phoneNumber,

    )
    );
  }
  void saveUserA(AuthCredential userCredential1) async{

    await FireStoreUser().addUserToFireStore(UserModel(
      userId :_auth.currentUser!.uid,
      name: name,
      phoneNumber: phoneNumber,

    )
    );
  }





}
