
import 'package:elderlycare/view/control_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view_model/auth_view_model.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_text_form_field.dart';

class OTPScreen extends GetWidget<AuthViewModel> {
  final GlobalKey<FormState> _globalKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Padding(

        padding: EdgeInsets.only(
          top: 50,
          right: 20,
          left: 20,
        ),
        child: Form(
          key: _globalKey,
          child: Column(

            children: [
              customText(
                text: 'Enter SMS code,',
                fontSize: 30,


              ),

              SizedBox(
                height: 30,
              ),
              CustomTextFormField(
                text: 'OTP',
                hint: 'Enter your OTP',
                onSave: (value){
                  controller.otp=value!;

                },
                validator: (value){
                  if(value==null){
                    print('error');
                  }
                },
              ),

              SizedBox(
                height: 20,
              ),
              CustomButton(
                  text: 'sign in',
                  onPressed:(){

                    _globalKey.currentState?.save();
                    if(_globalKey.currentState!.validate()){
                      controller.verifyOTP(controller.otp);

                    }

                  },

              ),


            ],
          ),
        ),
      ),
    );
  }
}
