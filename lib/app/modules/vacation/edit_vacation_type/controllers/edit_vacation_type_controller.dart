import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EditVacationTypeController extends GetxController {
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    //  await getBranch();
    await vacationInfo();
  }

  dynamic vacaiton = Get.arguments;

  final vacationType = TextEditingController().obs;
  final vacationDays = TextEditingController().obs;
  RxString vacationStatus = 'active'.obs;
  RxString isPaidValue = 'No'.obs;
  RxBool isPaid = false.obs;
  final vacationStatusItems = ['active', 'inactive'];
  final isPaidItems = ['Yes', 'No'];
  CollectionReference fireStore =
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
      fireStore.doc(vacaiton['vacationId']).update({
        'vacationType': vacationType.value.text,
        'vacationStatus': vacationStatus.value,
        'vacationDays': vacationDays.value.text,
      }).whenComplete(() {
        vacationType.value.text = '';
        vacationDays.value.text = '';
      });
    }
  }

  Future vacationInfo() async {
    //vacationType.value = vacaiton['vacationType'];
    print(vacaiton['vacationType']);
  }
}
