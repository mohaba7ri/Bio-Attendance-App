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

  final vacation;
  EditVacationTypeController({required this.vacation});

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
      fireStore.doc(vacation['vacationId']).update({
        'vacationType': vacationType.value.text,
        'vacationStatus': vacationStatus.value,
        'vacationDays': vacationDays.value.text,
      }).whenComplete(() {
        Get.back();
      });
    }
  }

  Future vacationInfo() async {
    vacationType.value.text = vacation['vacationType'];
    vacationDays.value.text = vacation['vacationDays'];
    print(vacation['vacationType']);
  }
}
