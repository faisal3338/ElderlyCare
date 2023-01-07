import 'package:elderlycare/view_model/auth_view_model.dart';
import 'package:get/get.dart';

import '../view_model/appointment_view_model.dart';

class Binding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => AuthViewModel());
   Get.lazyPut(() => AppointmentViewModel(),fenix: true);
  }

}