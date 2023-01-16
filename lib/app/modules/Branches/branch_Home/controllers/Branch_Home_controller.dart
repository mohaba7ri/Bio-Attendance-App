import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:presence/app/routes/app_pages.dart';

class BranchHomeController extends GetxController {
  bool isLougout = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    print("called");
    String uid = auth.currentUser!.uid;
    yield* firestore.collection("user").doc(uid).snapshots();
  }

  bool isLogout() {
    return isLougout = true;
  }

  void logout() async {
    if (!isLougout) {
      await auth.signOut();
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}