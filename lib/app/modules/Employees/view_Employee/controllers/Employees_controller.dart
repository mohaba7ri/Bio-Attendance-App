import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';

class ListEmployeeController extends GetxController {
  //dynamic EmpList;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> Employee() async* {
    print("called");
    // String uid = auth.currentUser!.uid;
    yield* firestore.collection("user").snapshots();
  }
}
