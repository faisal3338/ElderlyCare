import 'package:elderlycare/home/home.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(ElderlyCare(),);
}

class ElderlyCare extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}
