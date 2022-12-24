import 'package:elderlycare/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth/login_screen.dart';
import 'home/home.dart';

class controlView extends GetWidget<AuthViewModel> {


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (Get.find<AuthViewModel>().user !=null)
          ? Home()
          :LoginScreen();
    });
  }
}
