import 'package:flutter/material.dart';
import 'package:specialist_app/view/widgets/custom_text.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color color;

  CustomButton({
    required this.text,
    required this.onPressed,
    this.color=Colors.green,
  });


  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(15),
      color: color,
      child: customText(
        text: text,
        color: Colors.white,
        alignment: Alignment.center,

      ),
    );
  }
}
