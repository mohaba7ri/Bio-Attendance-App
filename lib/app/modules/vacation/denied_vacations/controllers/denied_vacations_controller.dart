import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DeniedVacationController extends GetxController {
  RxBool switchValue = false.obs;
  dynamic userInfo = Get.arguments;

  DateTime? start;
  DateTime end = DateTime.now();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> vacationRequests() async* {
    if (userInfo['role'] == 'SuperAdmin') {
      yield* firestore
          .collection('vacationRequest')
          .where("status", isEqualTo: "Denied")
          .snapshots();
    } else {
      yield* firestore
          .collection("user")
          .where("status", isEqualTo: "Denied")
          .where('branchId', isEqualTo: userInfo['branchId'])
          .snapshots();
    }
  }

  void pickDate(DateTime pickStart, DateTime pickEnd) {
    start = pickStart;
    end = pickEnd;

    update();
    Get.back();
  }
}
