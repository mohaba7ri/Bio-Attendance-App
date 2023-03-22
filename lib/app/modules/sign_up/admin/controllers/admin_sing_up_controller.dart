import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../../widgets/toast/custom_toast.dart';

class AdminSignUpController extends GetxController {
  RxBool isLoading = false.obs;
  RxString docId = Get.arguments;
  RxBool isLoadingCreatePegawai = false.obs;
  late String name;
  late String phone;
  late String email;
  late String password;
  late String job;
  final String role = 'superadmin';
  CollectionReference users = FirebaseFirestore.instance.collection('user');
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signUp() async {
    if (name.isNotEmpty &&
        phone.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty) {
      isLoading.value = true;
      try {
        if (isLoadingCreatePegawai.isFalse) {
          await createEmployeeData();
          //CustomToast.errorToast("success", "every thing is great");
          isLoading.value = false;
          Get.toNamed(Routes.LOGIN);
        }
      } catch (e) {
        print('error');
      }
    } else {
      print('thename is$name');
      CustomToast.errorToast("you_need_to_fill_all_fields".tr);
    }
  }

  createEmployeeData() async {
    if (password.isNotEmpty) {
      isLoadingCreatePegawai.value = true;
      try {
        UserCredential employeeCredential =
            await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (employeeCredential.user != null) {
          String uid = employeeCredential.user!.uid;
          await users.doc(uid).set({
            'employeeId': '12345678',
            'name': name,
            'phone': phone,
            'email': email,
            'job': job,
            'role': role,
            'createdAt': DateTime.now().toIso8601String(),
            'compId': docId.value,
            'branchId': docId.value,
          });
          await employeeCredential.user!.sendEmailVerification();
          isLoadingCreatePegawai.value = false;
        }
      } on FirebaseAuthException catch (e) {
        isLoadingCreatePegawai.value = false;
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          CustomToast.errorToast('default_password_too_short'.tr);
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          CustomToast.errorToast('Email_already_exist'.tr);
        } else if (e.code == 'wrong-password') {
          CustomToast.errorToast('wrong_passowrd'.tr);
        } else {
          CustomToast.errorToast('error : ${e.code}');
        }
      } catch (e) {
        isLoadingCreatePegawai.value = false;
        CustomToast.errorToast('error : ${e.toString()}');
      }
    } else {
      CustomToast.errorToast('something_want_wrong'.tr);
    }
  }

  var textDecoration = InputDecoration(
    labelText: 'full_name'.tr,
    hintText: 'full_name'.tr,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
      10,
    )),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.indigoAccent, width: 2)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.brown, width: 1)),
  );
}
