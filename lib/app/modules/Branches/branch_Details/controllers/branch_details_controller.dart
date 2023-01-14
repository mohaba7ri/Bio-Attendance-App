import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';

class detailBranchController extends GetxController {
  dynamic brancList;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> branch() async* {
  //  yield* firestore.collection('branch').where('branchId', isEqualTo: branchId).snapshots();
  }
}
