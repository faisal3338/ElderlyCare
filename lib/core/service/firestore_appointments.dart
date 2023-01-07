import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../model/appointments_model.dart';

class FireStoreAppointments{
  final CollectionReference _appointmentsRef=
      FirebaseFirestore.instance.collection('Appointments');

  RxList<AppointmentsModel> appointmentsList= <AppointmentsModel>[].obs;
}