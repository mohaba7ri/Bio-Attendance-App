import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';


import '../../../../routes/app_pages.dart';
import '../../../../widgets/custom_animation.dart';

class CompanyHomeController extends GetxController {
  bool isLoading = false;
  bool isLougout = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamCompany() async* {
    isLoading = true;
    final Stream<QuerySnapshot> companyStream =
        FirebaseFirestore.instance.collection('company').snapshots();
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    
  }

  bool isLogout() {
    return isLougout = true;
  }

  void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.light
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.grey.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false
      ..customAnimation = CustomAnimation();
  }

  void logout() async {
    if (!isLougout) {
      await auth.signOut();
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
