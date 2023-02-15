import 'package:elderlycare/payment/remove_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/widgets/custom_card_payment.dart';
import '../view_model/card_payment_view_model.dart';
import 'add_card_payment.dart';


class MyCardPayment extends GetWidget<CardPaymentViewModel> {
  final GlobalKey<FormState> _globalKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color.fromRGBO(175,176,200, 6),
      appBar: AppBar(
        title: Text("My Cards "+controller.getMyCardList.length.toString()),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[Colors.purple, Colors.blue])),),
        actions: [
          IconButton(onPressed:(){ Get.off(RemoveCard());}, icon: Icon(Icons.delete)),
        ],
      ),
      body: Form(
        key: _globalKey,
        child: ListView.builder(
            itemCount: controller.getMyCardList.length,
            itemBuilder: (context, index) {
              return
                Container(

                  child: custom_card_payment( cardNumber: controller.getMyCardList[index].cardNumber,
                      cardHolder: controller.getMyCardList[index].cardHolder,
                      cardExpiration: controller.getMyCardList[index].cardExpiration,
                      cvv: controller.getMyCardList[index].cvv
                  ),
                );
            }
        ),
      ),

      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),
        onPressed: (){
          Get.off(AddCardPayment());
        },
      ),
    );
  }
}
