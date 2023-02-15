import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/specialist_model.dart';

class FireStoreSpecialist {
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('Specialists');

  Future<void> addSpecialistToFireStore(SpecialistModel specialistModel) async{
    return await _userCollectionRef.doc(specialistModel.specialistId).set(specialistModel.toJson());
  }
}