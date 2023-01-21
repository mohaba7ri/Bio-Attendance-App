import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:presence/app/routes/app_pages.dart';

class CompanyHomeController extends GetxController {
  bool isLougout = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamCompany() async* {
    final Stream<QuerySnapshot> companyStream =
        FirebaseFirestore.instance.collection('company').snapshots();
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
