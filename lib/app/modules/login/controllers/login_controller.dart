import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../controllers/page_index_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../util/app_constants.dart';
import '../../../widgets/dialog/custom_alert_dialog.dart';
import '../../../widgets/toast/custom_toast.dart';
import '../../languages/controller/languages_controller.dart';

class LoginController extends GetxController {
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }

  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;
  LoginController({required this.apiClient, required this.sharedPreferences});
  final pageIndexController = Get.find<PageIndexController>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;
  RxBool obsecureText = true.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  checkDefaultPassword() {
    if (passC.text == 'qwertyuiop')
      Get.toNamed(Routes.NEW_PASSWORD);
    else {
      Get.offAllNamed(Routes.HOME);
      pageIndexController.changePage(0);
    }
  }

  Future<bool> getUserToken(String? token) async {
    apiClient.token = token;
    // apiClient.updateHeader(token: token);

    return await sharedPreferences.setString(AppConstants.TOKEN, token!);
  }

  Future updateUser() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String? deviceToken = sharedPreferences.getString('deviceToken');
    if (deviceToken!.isNotEmpty) {
      await firestore
          .collection('user')
          .doc(sharedPreferences.getString('userId')!)
          .update({"deviceToken": deviceToken});
    }
  }

  Future<void> login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        final credential = await auth.signInWithEmailAndPassword(
          email: emailC.text.trim(),
          password: passC.text,
        );
        sharedPreferences.setString('userId', auth.currentUser!.uid);
        update();
        if (credential.user != null) {
          if (credential.user!.emailVerified) {
            isLoading.value = false;
            checkDefaultPassword();
          } else {
            CustomAlertDialog.showPresenceAlert(
              title: "Email not yet verified",
              message: "Are you want to send email verification?",
              onCancel: () => Get.back(),
              onConfirm: () async {
                try {
                  await credential.user!.sendEmailVerification();
                  Get.back();
                  CustomToast.successToast(
                      "We've send email verification to your email");
                  isLoading.value = false;
                } catch (e) {
                  CustomToast.errorToast(
                      "Cant send email verification. Error because : ${e.toString()}");
                }
              },
            );
          }
          await updateUser();
          update();
        }
        isLoading.value = false;
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'user-not-found') {
          CustomToast.errorToast("Account not found");
        } else if (e.code == 'wrong-password') {
          CustomToast.errorToast("Wrong Password");
        }
      } catch (e) {
        CustomToast.errorToast("Error because : ${e.toString()}");
      }
    } else {
      CustomToast.errorToast("You need to fill email and password form");
    }
  }
}
