import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';

class ListEmployeeRepController extends GetxController {
  //dynamic EmpList;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> Employee() async* {
    print("called");
    // String uid = sharedPreferences.getString('userId')!;
    yield* firestore.collection("user").snapshots();
  }
}
