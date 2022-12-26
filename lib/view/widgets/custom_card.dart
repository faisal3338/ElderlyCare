import 'package:flutter/material.dart';

class custom_card extends StatelessWidget {
  String image;
  String text;
  Color color;
  void Function()? onPressed;

  custom_card({
    required this.image,
    required this.text,
    required this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(

        height: 200,
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0x9F3D416E),
        ),
        child: Column(
          children: [
            Image.asset(
              image,
              width: 120,
              height: 120,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: TextStyle(color: color, fontSize: 23),
            ),
          ],
        ),
      ),
    );
  }
}