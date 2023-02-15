import 'package:elderlycare/view/auth/otp_screen.dart';
import 'package:elderlycare/view_model/auth_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:elderlycare/view/widgets/custom_button.dart';
import 'package:elderlycare/view/widgets/custom_text.dart';
import 'package:get/get.dart';

import '../widgets/custom_text_form_field.dart';

class LoginPhoneNumber extends GetWidget<AuthViewModel> {
  final GlobalKey<FormState> _globalKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        padding: EdgeInsets.all(15),

        child: Form(
          key: _globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 20,),
              new Image.asset(
                'assets/images/Login.png',

                fit: BoxFit.cover,
              ),

              // Container(height: 200,),
              Text("Hello,",style: TextStyle(fontSize: 50),),

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextFormField(

                    text: '',
                    hint:'Enter your name' ,
                    onSave: (value){
                      controller.name=value!;
                    },
                    validator: validateInput

                  ),

                  CustomTextFormField(
                    text: ' ',
                    hint: '557943347',
                    keyboardType: TextInputType.number,
                    onSave: (value){
                      controller.phoneNumber=value!;
                    },
                    validator: validateInput
                  ),
                ],
              ),

              CustomButton(
                  text: 'SIGN IN',
                  color: Color.fromARGB(255, 0, 136, 255),
                  onPressed: (){
                    _globalKey.currentState?.save();
                    if(_globalKey.currentState!.validate()){
                      controller.signInWithPhoneNumber();
                      Get.to(OTPScreen());
                    }
                  }
              ),

            ],
          ),
        ),
      ),
    );
  }
}
String? validateInput(String? value) {
  if (value == null || value.isEmpty) {
    return "This field is empty";
  }
}