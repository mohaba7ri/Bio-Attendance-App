import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../routes/app_pages.dart';

class BranchHomeController extends GetxController {
  BranchHomeController({required this.sharedPreferences});
  bool isLougout = false;
  String? role;

  FirebaseAuth auth = FirebaseAuth.instance;
  final SharedPreferences sharedPreferences;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    print("called");
    String uid = sharedPreferences.getString('userId')!;
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    role = sharedPreferences.getString('role');
  }
}
