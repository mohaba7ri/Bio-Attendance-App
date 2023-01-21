import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/widgets/toast/custom_toast.dart';

class CompanySettingController extends GetxController {
  Rx<TimeOfDay> startTime = TimeOfDay.now().obs;
  Rx<TimeOfDay> endTime = TimeOfDay(hour: 2, minute: 00).obs;
  Rx<TimeOfDay> lateTime = TimeOfDay(hour: 8, minute: 30).obs;
  Rx<TimeOfDay> overlyTime = TimeOfDay(hour: 2, minute: 30).obs;
  RxBool isExistSetting = false.obs;

  final companySetting = FirebaseFirestore.instance;
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

  checkCompanySetting() {
    FirebaseFirestore.instance
        .collection("companySetting")
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

  Future<void> storeCompanySetting() async {
    DateTime now = DateTime.now();
    DateTime endTimeTimestamp = DateTime(
        now.year, now.month, now.day, endTime.value.hour, endTime.value.minute);
    String endTimeIsoString = endTimeTimestamp.toIso8601String();
    DateTime startTimeTimestamp = DateTime(now.year, now.month, now.day,
        startTime.value.hour, startTime.value.minute);
    String startTimeIsoString = startTimeTimestamp.toIso8601String();
    DateTime lateTimeTimestamp = DateTime(
        now.year, now.month, now.day, endTime.value.hour, endTime.value.minute);
    String lateTimeIsoString = lateTimeTimestamp.toIso8601String();
    DateTime overlyTimeTimestamp = DateTime(now.year, now.month, now.day,
        overlyTime.value.hour, overlyTime.value.minute);
    String overlyTimeIsoString = overlyTimeTimestamp.toIso8601String();
    try {
      await companySetting.collection('companySettings').doc().set({
        'startTime': startTimeIsoString,
        'lateTime': lateTimeIsoString,
        'endTime': endTimeIsoString,
        'overlyTime': overlyTimeIsoString,
      }).whenComplete(() => CustomToast.successToast(
          'Setting', 'Company Settings added successfully '));
    } catch (e) {
      CustomToast.errorToast('error', e.toString());
      print(e.toString());
    }
  }
}
