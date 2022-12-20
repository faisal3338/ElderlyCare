import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:elderlycare/view/widgets/custom_button.dart';
import 'package:elderlycare/view/widgets/custom_text.dart';

import '../widgets/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,

      ),
      body: Padding(

        padding: EdgeInsets.only(
          top: 50,
          right: 20,
          left: 20,
        ),
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
              validator: (value){},
              onSave: (value){},
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextFormField(
                text: 'Password',
                hint: 'password',
                onSave: (value){},
                validator: (value){},
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
                onPressed: (){}
            ),
            SizedBox(
              height: 20,
            ),

            CustomButton(
                  text: 'SIGN IN  with Google',
                  onPressed: (){},
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                customText(
                  text: 'dont have an account?',
                  alignment: Alignment.center,
                ),
                CustomButton(
                    text: 'SING up',
                    onPressed: (){}
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
