import 'package:elderlycare/core/service/firestore_user.dart';
import 'package:elderlycare/view/auth/login_phone_number.dart';
import 'package:elderlycare/view/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/user_model.dart';

class AuthViewModel extends GetxController {
  GoogleSignIn _googleSignIn=GoogleSignIn(scopes: ['email']);
  FirebaseAuth _auth = FirebaseAuth.instance;


  late String email , password , name , phoneNumber;
  late var verificationId ='';
  late var otp;
  Rxn<User> _user= Rxn<User>();

  String? get user =>_user.value?.email;

  void onInit(){

    super.onInit();
    _user.bindStream(_auth.authStateChanges());
  }





  void googleSignInMethod()async{
    final GoogleSignInAccount? googleUser= await _googleSignIn.signIn();
    if(googleUser != null){

      GoogleSignInAuthentication googleSignInAuthentication= await googleUser.authentication;

      final AuthCredential credential=GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      // UserCredential userCredential =
      await _auth.signInWithCredential(credential).then((user) async{
        await FireStoreUser().addUserToFireStore(UserModel(

          userId :googleUser.id,
          email: googleUser.email,
          name: googleUser.displayName!,
          phoneNumber: '555',
        )
        );
      });

      // print(userCredential.user?.phoneNumber);
      Get.offAll(Home());
    }


  }
  void signInWithEmailAndPassword() async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password, );
      Get.offAll(Home());
    }catch(e){
      Get.snackbar('Error login account', e.toString(),
      colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM
      );
    }
  }

  void createAccountWithEmailAndPassword() async{
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((user) {
        saveUser(user);
      });
      Get.offAll(Home());
    }catch(e){
      Get.snackbar('Error login account', e.toString(),
          colorText: Colors.black,
          snackPosition: SnackPosition.BOTTOM
      );
    }
  }
  void signInWithPhoneNumber() async{
    print(phoneNumber);
   await _auth.verifyPhoneNumber(
     phoneNumber: phoneNumber,
       verificationCompleted: (AuthCredential authCredential) async{
       await _auth.signInWithCredential(authCredential);
       },
       // verificationFailed: (e){
       // if(e.code=='invalid-phone-number'){
       //   Get.snackbar('Error', 'The provided number is not valid');
       // }
       // else{
       //   Get.snackbar('Error', 'Something went wrong. Try again');
       //
       // }
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
        Get.to(Home());
      }
    } on Exception catch (e) {
      Get.snackbar("otp info", "otp code is not correct !!");
    }
  }
  void saveUser(UserCredential userCredential) async{
    await FireStoreUser().addUserToFireStore(UserModel(
      userId :userCredential.user!.uid,
      email: email,
      name: name,
      phoneNumber: phoneNumber,
    )
    );
  }



}
