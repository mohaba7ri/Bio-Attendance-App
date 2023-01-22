import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/widgets/toast/custom_toast.dart';

class CompanySettingController extends GetxController {
  String? companyId;
  RxString companySettingId = ''.obs;

  CompanySettingController({this.companyId});
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print('companyID${companyId}');
    checkCompanySetting()
        .whenComplete(() => print('companySetting${companySettingId}'));
  }

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

  Future<void> checkCompanySetting() async {
    final QuerySnapshot companySetting =
        await FirebaseFirestore.instance.collection("companySettings").get();
    for (var document in companySetting.docs) {
      print(document.id);
      companySettingId.value = document.id;
      print('companySettingID${companySettingId}');
    }
    if (companySetting.docs.isNotEmpty) {
      isExistSetting.value = true;
    }
  }

  Future<void> storeCompanySetting() async {
    DateTime now = DateTime.now();
    DateTime endTimeTimestamp = DateTime(
        now.year, now.month, now.day, endTime.value.hour, endTime.value.minute);
    String endTimeIsoString = endTimeTimestamp.toIso8601String();
    DateTime startTimeTimestamp = DateTime(now.year, now.month, now.day,
        startTime.value.hour, startTime.value.minute);
    String startTimeIsoString = startTimeTimestamp.toIso8601String();
    DateTime lateTimeTimestamp = DateTime(now.year, now.month, now.day,
        lateTime.value.hour, lateTime.value.minute);
    String lateTimeIsoString = lateTimeTimestamp.toIso8601String();
    DateTime overlyTimeTimestamp = DateTime(now.year, now.month, now.day,
        overlyTime.value.hour, overlyTime.value.minute);
    String overlyTimeIsoString = overlyTimeTimestamp.toIso8601String();
    try {
      final companySettingRef = companySetting.collection('companySettings');
      final querySnapshot = await companySettingRef.get();
      if (querySnapshot.docs.isEmpty) {
        companySettingRef.doc().set({
          'startTime': startTimeIsoString,
          'lateTime': lateTimeIsoString,
          'endTime': endTimeIsoString,
          'overlyTime': overlyTimeIsoString,
          'companyId': companyId,
        });
        CustomToast.successToast(
            'Success', 'CompanySetting added successfully');
      } else {
        if (isExistSetting.value == true) {
          companySettingRef.doc(companySettingId.value).update({
            'startTime': startTimeIsoString,
            'lateTime': lateTimeIsoString,
            'endTime': endTimeIsoString,
            'overlyTime': overlyTimeIsoString,
            'companyId': companyId,
          });
          CustomToast.successToast(
              'Success', 'CompanySetting updated successfully');
        }
      }
    } catch (e) {
      CustomToast.errorToast('Error', e.toString());
      print(e.toString());
    }
  }
}
