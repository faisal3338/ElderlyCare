import 'package:elderlycare/payment/my_card_payment.dart';
import 'package:elderlycare/view/appointments/appointments_screen.dart';
import 'package:elderlycare/view/auth/login_phone_number.dart';
import 'package:elderlycare/view/map/maps.dart';
import 'package:elderlycare/view/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/custom_card.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

FirebaseAuth _auth =FirebaseAuth.instance;
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xF2262254),
      bottomNavigationBar: Container(
        height: 80,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        //   color: Color(0xFF373856),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Elderly Care',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    // Text(
                    //   'Glassify this transaction into a \n pticular catigory ',
                    //   style: TextStyle(color: Colors.white, fontSize: 18),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              custom_card(
                                image: 'assets/images/Icon1.png',
                                text: 'My Location',
                                color: Color(0xFF47B4FF),
                                onPressed:(){
                                  Get.to(MapPageState());
                                }
                              ),
                              custom_card(
                                image: 'assets/images/Icon2.png',
                                text: 'Payment',
                                color: Color(0xFFA885FF),
                                onPressed: (){
                                  Get.to(MyCardPayment());
                                },
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              custom_card(
                                image: 'assets/images/Icon3.png',
                                text: 'Order',
                                color: Color(0xFFFD47DF),
                                onPressed: (){
                                  Get.to(AppointmentScreen());
                                },
                              ),
                              custom_card(
                                image: 'assets/images/Icon4.png',
                                text: 'About',
                                color: Color(0xFFFD8C44),
                                onPressed: null,
                              ),

                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CustomButton(
                              text: 'logout',
                              color: Colors.red,
                              onPressed: (){
                                _auth.signOut();
                                Get.offAll(LoginPhoneNumber());
                              }
                          )
                          // SizedBox(height: 20),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     CatigoryW(
                          //       image: 'images/Icon5.png',
                          //       text: 'Entertainment',
                          //       color: Color(0xFF7DA4FF),
                          //     ),
                          //     CatigoryW(
                          //       image: 'images/Icon6.png',
                          //       text: 'Grocery',
                          //       color: Color(0xFF43DC64),
                          //     )
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
