import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';

class AddVacationTypeController extends GetxController {
  TextEditingController vacationType = TextEditingController();
  RxString statusValue = 'active'.obs;
  RxString isPiadValue = 'No'.obs;
  RxBool isPaid = false.obs;
  var statusItems = ['active', 'inactive'];
  var isPaidItems = ['Yes', 'No'];

  changeIsPaid() {
    isPiadValue.value == 'No' ? isPaid.value = false : isPaid.value = true;
  }

  changeStatusValue(String value) {
    statusValue.value = value;
  }

  changeIsPaidValue(String value) {
    isPiadValue.value = value;
  }
}
