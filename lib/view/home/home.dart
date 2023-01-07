import 'package:elderlycare/view/appointments/appointments_screen.dart';
import 'package:elderlycare/view/auth/login_screen.dart';
import 'package:elderlycare/view/map/maps.dart';
import 'package:elderlycare/view/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/register_screen.dart';
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
            // children: [
            //   Image.asset(
            //     'images/Icon7.png',
            //     height: 60,
            //     width: 60,
            //   ),
            //   Image.asset(
            //     'images/Icon8.png',
            //     height: 60,
            //     width: 60,
            //   ),
            //   Image.asset(
            //     'images/Icon9.png',
            //     height: 60,
            //     width: 60,
            //   ),
            // ],
          ),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              // Transform.rotate(
              //   origin: Offset(30, -60),
              //   angle: 2.4,
              //   child: Container(
              //     margin: EdgeInsets.only(
              //       left: 75,
              //       top: 40,
              //     ),
              //     height: 400,
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(80),
              //       gradient: LinearGradient(
              //         begin: Alignment.bottomLeft,
              //         colors: [Color(0xffFD8BAB), Color(0xFFFD44C4)],
              //       ),
              //     ),
              //   ),
              // ),
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
                                  Get.to(MapPage());
                                }
                              ),
                              custom_card(
                                image: 'assets/images/Icon2.png',
                                text: 'Payment',
                                color: Color(0xFFA885FF),
                                onPressed: null,
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
                                Get.offAll(LoginScreen());
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
