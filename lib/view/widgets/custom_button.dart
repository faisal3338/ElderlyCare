import 'package:flutter/material.dart';
import 'package:elderlycare/view/widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  CustomButton({
    required this.text,
    required this.onPressed,
  });




  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(20),
      color: Colors.green,
      child: customText(
        text: text,
        color: Colors.white,
        alignment: Alignment.center,
      ),
    )
    ;
  }
}
