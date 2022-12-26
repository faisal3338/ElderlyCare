import 'package:elderlycare/view/auth/register_screen.dart';
import 'package:elderlycare/view_model/auth_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:elderlycare/view/widgets/custom_button.dart';
import 'package:elderlycare/view/widgets/custom_text.dart';
import 'package:get/get.dart';

import '../widgets/custom_text_form_field.dart';

class LoginScreen extends GetWidget<AuthViewModel> {
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
                text: 'Welcome,',
                fontSize: 30,


              ),
              customText(
               text: 'Sign in to Continue',
                fontSize: 14,
                color: Colors.grey,
              ),
              SizedBox(
                height: 30,
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
              customText(
                text: 'Forget Password',
                fontSize: 14,
                alignment: Alignment.topRight,


              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                  text: 'SIGN IN',
                  onPressed: (){
                    _globalKey.currentState?.save();
                    if(_globalKey.currentState!.validate()){
                      controller.signInWithEmailAndPassword();
                    }

                  }
              ),
              SizedBox(
                height: 20,
              ),

              CustomButton(
                    text: 'SIGN IN  with Google',
                    onPressed: (){
                      controller.googleSignInMethod();

                    },
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  customText(
                    text: 'I do not have an account?',
                    alignment: Alignment.center,
                  ),
                  TextButton(onPressed: (){
                    Get.to(RegisterScreen());
                  }, child: Text('SING Up Now'))
                  // CustomButton(
                  //     text: 'SING up now',
                  //
                  //     onPressed: (){
                  //       Get.to(RegisterScreen());
                  //     }
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
