

import 'package:elderlycare/payment/cash.dart';
import 'package:elderlycare/payment/credit_card.dart';
import 'package:elderlycare/payment/instalment_payment.dart';
import 'package:elderlycare/view_model/appointment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:moyasar_payment/model/paymodel.dart';
import 'package:moyasar_payment/model/source/creditcardmodel.dart';
import 'package:moyasar_payment/moyasar_payment.dart';


Map<String, dynamic>? paymentIntent;
enum String { cash, credit_card, instalment_payment }

class Checkout extends GetWidget<AppointmentViewModel> {
late int index;

Checkout(this.index);

// Bottomsheet
  // bool bottomIsChecked = false;
  String? selectPaymentMethod = String.cash;

  @override
  Widget build(BuildContext context) {
print(index);
    return Scaffold(

      backgroundColor: Color.fromRGBO(175,176,200, 6),
      appBar: AppBar(
          title: Text('Bill Details'),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[Colors.purple, Colors.blue])),          )
      ),
      body: Column(


        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          //------------------------------------------------------------------
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(

              children:  [
                Text("Bill Details",style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold)),
                Divider(thickness: 3,color: Colors.black54,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text("Specialist name:                                      ${controller.appointmentsList.value[index].specialist}",style: TextStyle(fontSize: 17.0,)),
                    Divider(thickness: 2),
                    Text("Price                                                          ${controller.appointmentsList.value[index].price}",style: TextStyle(fontSize: 17.0,)),
                    Divider(thickness: 2),
                    Text("Date                                                           ${ DateFormat('dd-MM').format( controller.appointmentsList.value[index].dateTime)}",style: TextStyle(fontSize: 17.0,)),
                    Divider(thickness: 3),
                    Text("Time                                                          ${  DateFormat('hh:mm').format( controller.appointmentsList.value[index].dateTime)}",style: TextStyle(fontSize: 17.0,)),
                    Divider(thickness: 3),
                    Text("Duration                                                 2-hours ",style: TextStyle(fontSize: 17.0,)),
                    Divider(thickness: 3),
                    Text("Payment Type                                            ${controller.paymentMethod}",style: TextStyle(fontSize: 17.0,)),
                    SizedBox(height: 200,)
                  ],
                ),
              ],
            ),
          ),
          //----------------------------------------------------------------------
          SizedBox(
            width: 380,
            height: 80,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                            builder: (BuildContext context, StateSetter state) {
                              return Container(
                                color: Color.fromRGBO(175,176,200, 6),
                                padding: EdgeInsets.only(bottom: 50),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(18.0),
                                          child: Text(
                                              "Select payment method", style: TextStyle(fontSize: 18)),
                                        )),

                                    Row(
                                      //mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Radio(
                                          value: String.cash,
                                          groupValue: selectPaymentMethod,
                                          onChanged: (value) {
                                            state(() {
                                              selectPaymentMethod = value!;
                                            });
                                          },
                                        ),
                                        const Text(
                                          'Cash',
                                        ),


                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                          value: String.credit_card,
                                          groupValue: selectPaymentMethod,
                                          onChanged: (value) {
                                            state(() {
                                              selectPaymentMethod = value!;
                                            });
                                          },
                                        ),
                                        const Text(
                                          'Credit card',
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                          value: String.instalment_payment,
                                          groupValue: selectPaymentMethod,
                                          onChanged: (value) {
                                            state(() {
                                              selectPaymentMethod = value!;
                                            });
                                          },
                                        ),
                                        const Text(
                                          'Instalment Payment',
                                        ),
                                      ],
                                    ),
                                    //********************************************
                                    SizedBox(
                                      child: SizedBox(
                                        width: 350.0,
                                        height: 80.0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: ElevatedButton.icon(
                                              icon: const Icon(Icons.payment),

                                              onPressed: (){
                                                if(selectPaymentMethod==String.cash) {
                                                  controller.paymentMethod='cash';
                                                  Get.off(Cash(index));
                                                  print(selectPaymentMethod);//
                                                  // Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(builder: (context) => const Cash()),
                                                  // );
                                                }else if(selectPaymentMethod==String.credit_card){
                                                  controller.paymentMethod='credit_card';
                                                  Get.off(Credit_Cards(index));
                                                  print(selectPaymentMethod);
                                                  // Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(builder: (context) => const Credit_Card()),
                                                  // );
                                                }else{
                                                  print(selectPaymentMethod);//
                                                  controller.paymentMethod='Installment_Payment';
                                                  Get.off(Installment_Payment(index));
                                                  // Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(builder: (context) => const Installment_Payment()),
                                                  // );
                                                }
                                              },
                                              label: const Text("Select")),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,)
                                  ],
                                ),
                              );
                            });
                      });
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
                  elevation: MaterialStateProperty.all(18),
                  shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                  backgroundColor: MaterialStateProperty.all(Color.fromRGBO(242,184,67,4)),
                  shadowColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.onSurface),
                ),
                child: const Text("Change payment methods",  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                ),
              ),
            ),
          ),
          //-------------------Payment buttom---------------------------------
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   children: [
          //     SizedBox(height: 360,),
          //     Center(
          //       child: Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 30),
          //         child: SizedBox(
          //           height: 60,
          //           width: double.infinity,
          //           child: Container(
          //             decoration:  BoxDecoration(
          //               borderRadius: BorderRadius.circular(20),
          //               gradient: LinearGradient(
          //                 transform: GradientRotation(20),
          //                 colors: <Color>[
          //                   Color(0xFF439cfb),
          //                   Color(0xFFf187fb),
          //                 ],
          //               ),
          //             ),
          //             child: TextButton(
          //               style: TextButton.styleFrom(
          //                 padding: const EdgeInsets.all(16.0),
          //                 primary: Colors.white,
          //                 textStyle: const TextStyle(fontSize: 20),
          //               ),
          //               onPressed: () async {
          //                 controller.bookAppointment(controller.appointmentsList.value[index].appointmentId);
          //                 PayModel res = await MoyasarPayment().creditCard(
          //                     description :'description',
          //                     amount: 1.0,
          //                     publishableKey: "sk_test_eLoQR8wrVpopqTHftA9pSGKi2VbKBgrAAHE9nfSt",
          //                     cardHolderName: "Faisal Ali",
          //                     cardNumber: '5457210001000092',
          //                     cvv: 350,
          //                     expiryManth: 02,
          //                     expiryYear: 25,
          //                     callbackUrl: 'https://google.com');
          //                 CreditcardModel creditcardModel = CreditcardModel.fromJson(res.source);
          //                 print(creditcardModel.toJson());
          //                 print(res.status);
          //                 if(res.status=="initiated"){
          //                   print("yes");
          //                   print(res.id);
          //                   showDialog(
          //                       context: context,
          //                       builder: (_) => AlertDialog(
          //                         content: Column(
          //                           mainAxisSize: MainAxisSize.min,
          //                           children: [
          //                             Row(
          //                               children: const [
          //                                 Icon(Icons.check_circle, color: Colors.green,),
          //                                 Text("Payment Successfully"),
          //
          //                               ],
          //                             ),
          //                           ],
          //                         ),
          //                       ));
          //                 }else{
          //                   print("Error");
          //                 }
          //               },
          //               child: const Text(
          //                 'Payment',
          //                 style: TextStyle(
          //                   fontSize: 25,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
//------------------------------------------------------------------------------
//}