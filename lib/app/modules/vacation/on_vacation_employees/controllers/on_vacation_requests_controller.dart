import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class OnVacationController extends GetxController {
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await vacationRequests();
  }

  RxBool switchValue = false.obs;
  dynamic userInfo = Get.arguments;

  DateTime? start;
  DateTime end = DateTime.now();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> vacationRequests() async* {
    if (userInfo['role'] == 'SuperAdmin') {
      yield* firestore
          .collection('vacationRequest')
          .where("status", isEqualTo: "Approved")
          .snapshots();
    } else {
      yield* firestore
          .collection("vacationRequest")
          .where("status", isEqualTo: "Approved")
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
