import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manger_app/view/home/home.dart';

import '../view_model/auth_view_model.dart';
import 'appointments/appointments_screen.dart';
import 'auth/login_phone_number.dart';


class controlView extends GetWidget<AuthViewModel> {


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (Get.find<AuthViewModel>().user !=null)
          ? Home_Screen()
          :LoginPhoneNumber();
    });
  }
}
