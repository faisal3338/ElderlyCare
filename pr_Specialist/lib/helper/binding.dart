
import 'package:get/get.dart';
import 'package:specialist_app/view_model/auth_view_model.dart';

import '../view_model/appointment_view_model.dart';

class Binding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => AuthViewModel());
   Get.lazyPut(() => AppointmentViewModel(),fenix: true);
  }

}