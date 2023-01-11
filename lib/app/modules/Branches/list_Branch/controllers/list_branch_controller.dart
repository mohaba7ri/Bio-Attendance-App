import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class list_Branches_controller extends GetxController {
 

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getAllBranches() async {
   
    QuerySnapshot<Map<String, dynamic>> query =
        await firestore.collection("branch").get();
    return query;
  }

  
}
