import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class OnVacationController extends GetxController {
  RxBool switchValue = false.obs;

 DateTime? start;
  DateTime end = DateTime.now();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> vacationRequests() async* {
    yield* firestore.collection('vacationRequest').snapshots();
  }


  void pickDate(DateTime pickStart, DateTime pickEnd) {
    start = pickStart;
    end = pickEnd;

    update();
    Get.back();
  }
}
