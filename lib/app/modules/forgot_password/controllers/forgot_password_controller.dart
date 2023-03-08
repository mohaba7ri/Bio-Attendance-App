import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../widgets/toast/custom_toast.dart';

class ForgotPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> sendEmail() async {
    if (emailC.text.isNotEmpty) {
      isLoading.value = true;
      print("called");
      try {
        print("success");
        auth.sendPasswordResetEmail(email: emailC.text);
        Get.back();
        CustomToast.successToast( "We've send password reset link to your email");
      } catch (e) {
        CustomToast.errorToast( "Cant send password reset link to your email. Error because : ${e.toString()}");
      } finally {
        isLoading.value = false;
      }
    } else {
      CustomToast.errorToast( "Email must be filled");
    }
  }
}
