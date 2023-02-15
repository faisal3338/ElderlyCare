import 'package:elderlycare/payment/thank_you_page.dart';
import 'package:elderlycare/view_model/card_payment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:moyasar_payment/model/paymodel.dart';
import 'package:moyasar_payment/model/source/creditcardmodel.dart';
import 'package:moyasar_payment/moyasar_payment.dart';

import '../view/widgets/custom_card_payment.dart';
import '../view_model/appointment_view_model.dart';

class E_Wallet extends StatefulWidget {
  const E_Wallet({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<E_Wallet> {
  final GlobalKey<FormState> _globalKey=GlobalKey<FormState>();

  final selectObj=Get.put(CardPaymentViewModel());
  final appointmentCOntroller=Get.put(AppointmentViewModel());

  String amount='0';






  @override
  Widget build(BuildContext context) {
    appointmentCOntroller.onInit();
    // selectObj.onInit();

    return Scaffold(
      backgroundColor: Color.fromRGBO(175,176,200, 6),
      appBar: AppBar(
          title:  Text("Complete Instalment Payment"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[Colors.purple, Colors.blue])),          )
      ),
      body: Center(
        child: Form(
          key: _globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13.0),
                ),

                // color:Color.fromRGBO(86,93,147,4),
                shadowColor: Colors.blueGrey,
                elevation: 10,
                margin:  EdgeInsets.all(10),
                borderOnForeground: true,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),

                      title:  Text('${appointmentCOntroller.userInfo?['wallet']} SAR'
                        ,style: TextStyle(fontSize: 40),
                      ),
                    ),
                    SizedBox(height: 60)
                  ],
                ),

              ),
              SizedBox(height: 20,),

              Text("Select the card you want to pay", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),

              ),

              Obx(
                    () =>
                    DropdownButton<custom_card_payment>(

                      hint:  selectObj.myCardList!=null
                        ?Text("Select a Card")
                        :Text("no card is Added"),

                      value:selectObj.cardSelected,
                      onChanged: (dynamic? selectedObject) {
                        setState(() {
                          selectObj.cardSelected=selectedObject!;



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
              Container(
                margin: new EdgeInsets.all(15.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter value to pay by Instalment Payment",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),

                      borderSide: BorderSide(
                          width: 2, color: Colors.black),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                  ],

                  onSaved: (value){
                    amount=value!;
                  },
                ),
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
                      _globalKey.currentState?.save();
                      if(selectObj.cardSelected==null ||double.parse(amount)<=0){
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
                          amount: double.parse(amount),
                          publishableKey: "sk_test_eLoQR8wrVpopqTHftA9pSGKi2VbKBgrAAHE9nfSt",
                          cardHolderName: selectObj.cardSelected!.cardHolder.toString(),
                          cardNumber: selectObj.cardSelected!.cardNumber.replaceAll(RegExp(r'\s+'), ''),
                          cvv: 350,
                          expiryManth: int.parse(selectObj.cardSelected!.cardExpiration.substring(0,2)),
                          expiryYear:int.parse(selectObj.cardSelected!.cardExpiration.substring(3,5)),
                          callbackUrl: 'https://google.com');
                      CreditcardModel creditcardModel = CreditcardModel.fromJson(res.source);
                      print(creditcardModel.toJson());
                      print(res.status);
                      if(res.status=="initiated"){
                        appointmentCOntroller.chargeWallet(double.parse(amount));
                        appointmentCOntroller.onInit();
                        print("yes");
                        print(res.id);
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(Icons.check_circle, color: Colors.green,),
                                      Text("Payment Successfully"),

                                    ],
                                  ),
                                ],
                              ),
                            ));

                      }else{
                        print("Error");
                      }
                      //Get.off( E_Wallet());
                      Get.to(ThankYouPage(title: 'ok',));
                      setState(() {});
                    }},
                  ),
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
