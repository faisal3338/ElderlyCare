import 'package:elderlycare/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_text_form_field.dart';

class RegisterScreen extends GetView<AuthViewModel> {


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
                text: 'Sign UP,',
                fontSize: 30,

              ),

              SizedBox(
                height: 30,
              ),
              CustomTextFormField(

                text: 'name',
                hint:'Enter your name' ,
                onSave: (value){
                  controller.name=value!;
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
              CustomTextFormField(

                text: 'Email',
                hint:'Enter your Email' ,
                onSave: (value){
                  controller.email=value!;
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
              CustomTextFormField(
                text: 'Password',
                hint: 'password',
                onSave: (value){
                  controller.password=value!;
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
              CustomTextFormField(
                text: 'phone number',
                hint: 'enter your phone number',
                onSave: (value){
                  controller.phoneNumber=value!;
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
                  text: 'SIGN IN',
                  onPressed: (){
                    _globalKey.currentState?.save();
                    if(_globalKey.currentState!.validate()){
                      // controller.createAccountWithEmailAndPassword();
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