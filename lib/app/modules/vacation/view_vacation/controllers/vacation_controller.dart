import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';

class VacationTypeController extends GetxController {
  RxBool switchValue = false.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> vacationType() async* {
    yield* firestore.collection('vacationType').snapshots();
  }

  changeSwitchValue(String value) {
    if (value == 'active') {
      switchValue.value = true;
    } else {
      switchValue.value = false;
    }
  }
}
