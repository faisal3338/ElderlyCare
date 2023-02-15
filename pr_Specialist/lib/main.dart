import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:specialist_app/helper/binding.dart';
import 'package:specialist_app/view/control_view.dart';

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