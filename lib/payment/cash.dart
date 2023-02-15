

import 'package:elderlycare/payment/cash.dart';
import 'package:elderlycare/payment/instalment_payment.dart';
import 'package:elderlycare/payment/thank_you_page.dart';
import 'package:elderlycare/view/dower_pages/myBooking.dart';
import 'package:elderlycare/view_model/appointment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:moyasar_payment/model/paymodel.dart';
import 'package:moyasar_payment/model/source/creditcardmodel.dart';
import 'package:moyasar_payment/moyasar_payment.dart';


Map<String, dynamic>? paymentIntent;
enum String { cash, credit_card, instalment_payment }

class Cash extends GetWidget<AppointmentViewModel> {
  late int index;

  Cash(this.index);
// Bottomsheet
  // bool bottomIsChecked = false;
  String? selectPaymentMethod = String.cash;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Color.fromRGBO(175,176,200, 6),
      appBar: AppBar(
          title: Text('Cash'),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[Colors.purple, Colors.blue])),),
      ),
      body: Column(

        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          //-------------------Payment buttom---------------------------------
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height:320,),
              Text("Appointment Confirm ",  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),

              ),
              SizedBox(height: 50,),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: Container(
                      decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          transform: GradientRotation(20),
                          colors: <Color>[
                            Color(0xffffba42),
                            Color(0xffffba42),
                          ],
                        ),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(16.0),
                          primary: Colors.white,
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: () async {
                          controller.bookAppointmentByCash(controller.appointmentsList.value[index].appointmentId,
                              controller.appointmentsList.value[index].price);
                          // controller.bookAppointment(controller.appointmentsList.value[index].appointmentId);
                          // PayModel res = await MoyasarPayment().creditCard(
                          //     description :'description',
                          //     amount: 1.0,
                          //     publishableKey: "sk_test_eLoQR8wrVpopqTHftA9pSGKi2VbKBgrAAHE9nfSt",
                          //     cardHolderName: "Faisal Ali",
                          //     cardNumber: '5457210001000092',
                          //     cvv: 350,
                          //     expiryManth: 02,
                          //     expiryYear: 25,
                          //     callbackUrl: 'https://google.com');
                          // CreditcardModel creditcardModel = CreditcardModel.fromJson(res.source);
                          // print(creditcardModel.toJson());
                          // print(res.status);
                          // if(res.status=="initiated"){
                          //   print("yes");
                          //   print(res.id);
                          //   showDialog(
                          //       context: context,
                          //       builder: (_) => AlertDialog(
                          //         content: Column(
                          //           mainAxisSize: MainAxisSize.min,
                          //           children: [
                          //             Row(
                          //               children: const [
                          //                 Icon(Icons.check_circle, color: Colors.green,),
                          //                 Text("Payment Successfully"),
                          //
                          //               ],
                          //             ),
                          //           ],
                          //         ),
                          //       ));
                          // }else{
                          //   print("Error");
                          // }
                          //Get.offAll(MyBooked());
                          Get.offAll(ThankYouPage(title: 'ok',));
                        },
                        child: const Text(
                          'Order',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
//------------------------------------------------------------------------------
//}