import 'package:elderlycare/payment/thank_you_page.dart';
import 'package:elderlycare/view_model/appointment_view_model.dart';
import 'package:elderlycare/view_model/card_payment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:moyasar_payment/model/paymodel.dart';
import 'package:moyasar_payment/model/source/creditcardmodel.dart';
import 'package:moyasar_payment/moyasar_payment.dart';

import '../view/dower_pages/myBooking.dart';
import '../view/widgets/custom_card_payment.dart';

class Credit_Cards extends StatefulWidget {

 late int index;


 Credit_Cards(this.index);

  @override
  _MyHomePageState createState() => _MyHomePageState(index);
}

class _MyHomePageState extends State<Credit_Cards> {
late int index;

_MyHomePageState(this.index);

  final selectObj=Get.put(CardPaymentViewModel());
  final appointmentCOntroller=Get.put(AppointmentViewModel());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(175,176,200, 6),
      appBar: AppBar(
          title:  Text("Credit Cards"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[Colors.purple, Colors.blue])),)
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            // Card(
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(13.0),
            //   ),
            //
            //   // color:Color.fromRGBO(86,93,147,4),
            //   shadowColor: Colors.blueGrey,
            //   elevation: 10,
            //   margin: const EdgeInsets.all(10),
            //   borderOnForeground: true,
            //
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       ListTile(
            //         contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            //         title: Text('0.00 SAR'
            //           ,style: TextStyle(fontSize: 40),
            //         ),
            //       ),
            //       SizedBox(height: 60)
            //     ],
            //   ),
            //
            // ),
            SizedBox(height: 20,),

            Text("Select the card you want to pay", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),

            ),
            // DropdownButton(
            //
            //   // Initial Value
            //   value: 'select',
            //
            //   // Down Arrow Icon
            //   icon: const Icon(Icons.keyboard_arrow_down),
            //
            //   // Array list of items
            //   items: controller.getMyCardList.map((custom_card_payment card) {
            //     return DropdownMenuItem(
            //       value: controller.getMyCardList,
            //       child: Text(card.cardNumber),
            //     );
            //   }).toList(),
            //   // After selecting the desired option,it will
            //   // change button value to selected value
            //
            //   onChanged: (String? newValue) {
            //
            //       // dropdownvalue = newValue!;
            //
            //
            //   },
            // ),
            //
            // selectObj.cardSelected=selectObj.myCardList.value[] ,
            Obx(
                  () =>
                  DropdownButton<custom_card_payment>(
                    hint:  Text("Select a Card"),
                    value:selectObj.cardSelected,
                    onChanged: (dynamic? selectedObject) {
                      setState(() {
                        selectObj.cardSelected=selectedObject!;
                        //



                      });
                      print(selectObj.cardSelected?.cardNumber);
                      // handle selected object

                    },


                    items:
                    selectObj.myCardList.map<DropdownMenuItem<custom_card_payment>>((custom_card_payment value) {
                      return DropdownMenuItem<custom_card_payment>(
                        value: value,
                        child: Text(value.cardNumber ),

                      );
                    }).toList(),




                  ),
            ),

            SizedBox(
              height: 20,
            ),

            SizedBox(height: 30),

            SizedBox(
              width: 380,
              height: 80,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
                    elevation: MaterialStateProperty.all(18),
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                    backgroundColor: MaterialStateProperty.all(Color.fromRGBO(242,184,67,4)),
                    shadowColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.onSurface),
                  ),
                  child: const Text("pay",style: TextStyle(fontSize: 30),),
                  onPressed: () async{
                    if(selectObj.cardSelected==null ){
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children:  [
                                    Icon(Icons.error, color: Colors.red,),
                                    Container(
                                      child: selectObj.cardSelected ==null
                                          ?Text("Error, select card first")
                                          :Text("Error, Value is 0"),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ));
                    }

                  else{


                    PayModel res = await MoyasarPayment().creditCard(
                        description :'description',
                        amount: appointmentCOntroller.appointmentsList.value[index].price,
                        publishableKey: "sk_test_eLoQR8wrVpopqTHftA9pSGKi2VbKBgrAAHE9nfSt",
                        cardHolderName: selectObj.cardSelected!.cardHolder.toString(),
                        cardNumber: selectObj.cardSelected!.cardNumber.replaceAll(RegExp(r'\s+'), ''),
                        cvv: int.parse( selectObj.cardSelected!.cvv),
                        expiryManth: int.parse(selectObj.cardSelected!.cardExpiration.substring(0,2)),
                        expiryYear:int.parse(selectObj.cardSelected!.cardExpiration.substring(3,5)),
                        callbackUrl: 'https://google.com');
                    CreditcardModel creditcardModel = CreditcardModel.fromJson(res.source);
                    print(creditcardModel.toJson());
                    print(res.status);
                    if(res.status=="initiated") {
                      appointmentCOntroller.bookAppointmentByCard(
                          appointmentCOntroller.appointmentsList.value[index]
                              .appointmentId,
                          appointmentCOntroller.appointmentsList.value[index]
                              .price.toString());
                      print("yes");
                      print(res.id);
                      // Get.to(ThankYouPage(title: 'ok',));
                      showDialog(
                          context: context,
                          builder: (_) =>
                              AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(Icons.check_circle,
                                          color: Colors.green,),
                                        Text("Payment Successfully"),
                                      ],
                                    ),
                                  ],
                                ),
                              ));
                      Get.offAll(ThankYouPage(title: 'ok',));
                      // Get.off(MyBooked());
                    }}
                  // else{
                  //     showDialog(
                  //         context: context,
                  //         builder: (_) => AlertDialog(
                  //           content: Column(
                  //             mainAxisSize: MainAxisSize.min,
                  //             children: [
                  //               Row(
                  //                 children: const [
                  //                   Icon(Icons.error_outline, color: Colors.red,),
                  //                   Text("Error"),
                  //
                  //                 ],
                  //               ),
                  //             ],
                  //           ),
                  //         ));
                  //   }
                  },
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }
}
