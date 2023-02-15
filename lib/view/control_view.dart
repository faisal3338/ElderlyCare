import 'package:elderlycare/view/auth/login_phone_number.dart';
import 'package:elderlycare/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'home/home.dart';

import 'map/maps.dart';

class controlView extends GetWidget<AuthViewModel> {


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (Get.find<AuthViewModel>().user !=null)
          ? MapPageState()
          :LoginPhoneNumber();
    });
  }
}
