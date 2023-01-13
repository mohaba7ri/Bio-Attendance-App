import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BranchSettingController extends GetxController {
  Rx<TimeOfDay> startTime = TimeOfDay.now().obs;
  Rx<TimeOfDay> endTime = TimeOfDay(hour: 2, minute: 00).obs;
  Rx<TimeOfDay> lateTime = TimeOfDay(hour: 8, minute: 30).obs;
  Rx<TimeOfDay> overlyTime = TimeOfDay(hour: 2, minute: 30).obs;
  RxBool isExistSetting = false.obs;

  Future<TimeOfDay> showTimePickers(
      BuildContext context, TimeOfDay initialTime) async {
    final time = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    return time!;
  }

  void setStartTime(TimeOfDay time) {
    startTime.value = time;
  }

  void setEndtTime(TimeOfDay time) {
    endTime.value = time;
  }

  void setLateTime(TimeOfDay time) {
    endTime.value = time;
  }

  void setOverlyTime(TimeOfDay time) {
    endTime.value = time;
  }

  checkBranchSetting() {
    FirebaseFirestore.instance
        .collection("Branch")
        .doc("documentId")
        .get()
        .then((documentSnapshot) {
      if (documentSnapshot.exists) {
        isExistSetting.value = true;
      } else {
        print("Document doesn't exist!");
      }
    });
  }
}
