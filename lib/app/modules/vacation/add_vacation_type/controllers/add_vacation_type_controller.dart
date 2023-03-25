import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';
import 'package:uuid/uuid.dart';

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
    String docId = Uuid().v4();
    if (vacationType.value.text.isNotEmpty) {
      vacationStore.doc(docId).set({
        'vacationId': docId,
        'vacationType': vacationType.value.text,
        'vacationStatus': vacationStatus.value,
        'vacationDays': vacationDays.value.text,
      }).whenComplete(() {
        vacationType.value.text = '';
        vacationDays.value.text = '';
      });
    }
  }
}
