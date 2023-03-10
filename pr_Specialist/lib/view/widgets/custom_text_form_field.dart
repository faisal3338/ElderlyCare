
import 'package:flutter/material.dart';
import 'package:specialist_app/view/widgets/custom_text.dart';


class CustomTextFormField extends StatelessWidget {
 late final String text;
  final String hint;
  final void Function(String?)? onSave;
  final FormFieldValidator<String>? validator;
 final TextInputType? keyboardType;

   CustomTextFormField({
     required this.text,
     required this.hint,
     required this.onSave,
     required this.validator,
     this.keyboardType=TextInputType.text});




  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customText(
            text: text,
            color: Colors.black,
            fontSize: 14,
          ),
          TextFormField(
            onSaved: onSave,
            validator: validator,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: Colors.grey
              ),
              fillColor: Colors.white,
            ),

          )

        ],
      ),
    ) ;
  }
}
