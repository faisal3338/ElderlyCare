import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/manger_model.dart';



class FireStoreManger {
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('Manger');

  Future<void> addMangerToFireStore(MangerModel MangerModel) async{
    return await _userCollectionRef.doc(MangerModel.mangerId).set(MangerModel.toJson());
  }
}