import 'package:Biometric/app/controllers/presence_controller.dart';
import 'package:Biometric/app/modules/home/controllers/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  bool isLougout = false;
  final SharedPreferences sharedPreferences;
  ProfileController({required this.sharedPreferences});
  FirebaseAuth auth = FirebaseAuth.instance;

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
    await auth.signOut();
    Get.delete<HomeController>();
    Get.delete<PresenceController>();
    Get.offAllNamed(Routes.LOGIN);
  }
}
