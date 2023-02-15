import 'package:elderlycare/view_model/auth_view_model.dart';
import 'package:elderlycare/view_model/history_view_model.dart';
import 'package:get/get.dart';

import '../view_model/appointment_view_model.dart';
import '../view_model/card_payment_view_model.dart';

class Binding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => AuthViewModel(),fenix: true);
   Get.lazyPut(() => AppointmentViewModel(),fenix: true);
   Get.lazyPut(() => CardPaymentViewModel(),fenix: true);
   Get.lazyPut(() => HistoryViewModel(),fenix: true);
  }

}