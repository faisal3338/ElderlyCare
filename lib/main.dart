
import 'package:elderlycare/view/appointments/appointments_screen.dart';

import 'package:elderlycare/view/control_view.dart';
import 'package:elderlycare/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'helper/binding.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ElderlyCare(),);
}

class ElderlyCare extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: Binding(),
      home: controlView(),
    );
  }
}
