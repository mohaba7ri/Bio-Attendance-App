import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';

class vacationRequestDetailController extends GetxController {
  
    dynamic vacationRequest;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> vacationReq() async* {
  //  yield* firestore.collection('branch').where('branchId', isEqualTo: branchId).snapshots();
  }
}
