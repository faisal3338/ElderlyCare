import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../view/widgets/custom_card_payment.dart';


class CardPaymentViewModel extends GetxController {
  custom_card_payment? cardSelected;
  String cardNumber='';
  String cardHolder='';
  String cardExpiration='';
  String cvvCode='' ;
  RxList<custom_card_payment> myCardList = <custom_card_payment>[].obs;

  get getMyCardList => myCardList;

  void onInit()async{
    super.onInit();
loadCard();

  }
  addCardPayment() async{


    print('save');
    custom_card_payment card=custom_card_payment(
        // color: Colors.black54,
        cardExpiration: cardExpiration,
        cardHolder: cardHolder,
        cardNumber:cardNumber,
    cvv:cvvCode ,);
    myCardList.add(card);
    for(var doc in myCardList){
      card=custom_card_payment(
          cardExpiration: doc.cardExpiration,
          cardHolder: doc.cardHolder,
          cardNumber:doc.cardNumber,
      cvv: doc.cvv,);
      storeCard(card);
    }
storeCardFB(card);

  }
  storeCard(custom_card_payment card)async{
//

  }
  storeCardFB(custom_card_payment card){

    Map<String,dynamic>myMap={};
    int index=1;
    for(var doc in myCardList){
      card=custom_card_payment(
          cardExpiration: doc.cardExpiration,
          cardHolder: doc.cardHolder,
          cardNumber:doc.cardNumber,
      cvv: doc.cvv,);
      myMap[index.toString()]=custom_card_payment.toMap(card);
      index++;
    }


    FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid)
        .set({ "cards": myMap },
      SetOptions(merge: true),
    );
  }
  loadCard()async{
    myCardList.clear();
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    final Map<String, dynamic> cardsMap = snapshot["cards"];


     for(var card in cardsMap.values){
       myCardList.add(custom_card_payment.fromJson(card));
     }
     print(cardsMap.length);
  }

  removeCard(){

    custom_card_payment card;
    Map<String,dynamic>myMap={};
    int index=1;
    for(var doc in myCardList){
      card=custom_card_payment(
          cardExpiration: doc.cardExpiration,
          cardHolder: doc.cardHolder,
          cardNumber:doc.cardNumber,
      cvv: doc.cvv,);
      myMap[index.toString()]=custom_card_payment.toMap(card);
      index++;
    }
    FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid)
        .update({ "cards": myMap },

    );

  }



}
