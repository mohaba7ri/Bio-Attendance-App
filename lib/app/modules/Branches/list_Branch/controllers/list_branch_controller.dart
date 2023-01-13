import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';

class listBranchController extends GetxController {
  
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> branch() async* {
    yield* firestore.collection('branch').snapshots();
  }
}
