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
  RxBool isLoading2 = false.obs;

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
              title: "Email_not_yet_verified".tr,
              message: "Are_you_want_to_send_email_verification".tr,
              onCancel: () => Get.back(),
              onConfirm: () async {
                try {
                  await credential.user!.sendEmailVerification();
                  Get.back();
                  CustomToast.successToast("we_sent_email".tr);
                  isLoading.value = false;
                } catch (e) {
                  CustomToast.errorToast(
                      "Cant_send_email_verification_Error_because".tr +
                          " ${e.toString()}");
                }
              },
            );
          }
          await updateUser();
          await getUser();
          update();
        }
        isLoading.value = false;
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'user-not-found') {
          CustomToast.errorToast("Account_not_found".tr);
        } else if (e.code == 'wrong-password') {
          CustomToast.errorToast("Wrong_Password".tr);
        }
      } catch (e) {
        CustomToast.errorToast("Error_because".tr + "${e.toString()}");
      }
    } else {
      CustomToast.errorToast("You_need_to_fill_email_and_password_form".tr);
    }
  }

  Future getUser() async {
    String? role;
    await firestore
        .collection('user')
        .doc(sharedPreferences.getString('userId'))
        .get()
        .then((data) {
      role = data['role'];
      sharedPreferences.setString('role', role!);
      print('the role is :${sharedPreferences.getString('role')}');
    });
  }
}
