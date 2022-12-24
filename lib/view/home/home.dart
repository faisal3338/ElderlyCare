import 'package:elderlycare/view/auth/login_screen.dart';
import 'package:elderlycare/view/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
FirebaseAuth _auth =FirebaseAuth.instance;
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Elderly Care'),
      ),
      body: Column(
        children: [
          Container(
            alignment: AlignmentDirectional.topCenter,
            color: Colors.cyan,
            height: 300,
            child: Image.asset('assets/images/abc.png'),
          ),
          const SizedBox(
            height: 30,
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(30.0),
              textStyle: const TextStyle(fontSize: 20),
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
            ),
            onPressed: () {},
            child: const Text('Payment'),
          ),
          const SizedBox(
            height: 30,
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(30.0),
              textStyle: const TextStyle(fontSize: 20),
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
            ),
            onPressed: () {},
            child: const Text('Order'),

          ),
          CustomButton(
              text: 'logout',
              onPressed: (){
                _auth.signOut();
                Get.offAll(LoginScreen());
              }
          )
        ],
      ),
    );
  }

}