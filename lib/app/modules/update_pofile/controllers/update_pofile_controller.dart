import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../widgets/toast/custom_toast.dart';

class UpdatePofileController extends GetxController {
  RxBool isLoading = false.obs;
  final SharedPreferences sharedPreferences;
  UpdatePofileController({required this.sharedPreferences});
  TextEditingController employeeidC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;

  final ImagePicker picker = ImagePicker();
  XFile? image;

  Future<void> updateProfile() async {
    String uid = sharedPreferences.getString('userId')!;
    if (employeeidC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        Map<String, dynamic> data = {
          "name": nameC.text,
        };
        if (image != null) {
          // upload avatar image to storage
          File file = File(image!.path);
          String ext = image!.name.split(".").last;
          String upDir = "${uid}/avatar.$ext";
          await storage.ref(upDir).putFile(file);
          String avatarUrl = await storage.ref(upDir).getDownloadURL();

          data.addAll({"avatar": "$avatarUrl"});
        }
        await firestore.collection("user").doc(uid).update(data);
        image = null;
        Get.back();
        CustomToast.successToast('Success Update Profile');
      } catch (e) {
        CustomToast.errorToast('Cant Update Profile. Err : ${e.toString()}');
      } finally {
        isLoading.value = false;
      }
    } else {
      CustomToast.errorToast('You must fill all form');
    }
  }

  void pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      print(image!.path);
      print(image!.name.split(".").last);
    }
    update();
  }

  void deleteProfile() async {
    String uid = sharedPreferences.getString('userId')!;
    try {
      await firestore.collection("user").doc(uid).update({
        "avatar": FieldValue.delete(),
      });
      Get.back();

      Get.snackbar("Successfully", "Successfully deleted avatar profile");
    } catch (e) {
      Get.snackbar("There is an error",
          "Unable to delete avatar profile. Because ${e.toString()}");
    } finally {
      update();
    }
  }
}
