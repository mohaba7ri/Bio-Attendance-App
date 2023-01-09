import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';

class AddVacationTypeController extends GetxController {
  final vacationType = TextEditingController().obs;
  final vacationDays = TextEditingController().obs;
  RxString vacationStatus = 'active'.obs;
  RxString isPaidValue = 'No'.obs;
  RxBool isPaid = false.obs;
  final vacationStatusItems = ['active', 'inactive'];
  final isPaidItems = ['Yes', 'No'];
  CollectionReference vacationStore =
      FirebaseFirestore.instance.collection('vacationType');
  changeIsPaid() {
    isPaidValue.value == 'No' ? isPaid.value = false : isPaid.value = true;
  }

  changeStatusValue(String value) {
    vacationStatus.value = value;
  }

  changeIsPaidValue(String value) {
    isPaidValue.value = value;
  }

  void stroreVacationType() {
    if (vacationType.value.text.isNotEmpty) {
      vacationStore.doc().set({
        'vacationType': vacationType.value.text,
        'isPaid': isPaidValue.value,
        'vacationStatus': vacationStatus.value,
        'vacationDays': isPaid.value == true ? vacationDays.value.text : '',
      }).whenComplete(() {
        isPaid.value = false;
        vacationType.value.text = '';
      });
    }
  }
}
