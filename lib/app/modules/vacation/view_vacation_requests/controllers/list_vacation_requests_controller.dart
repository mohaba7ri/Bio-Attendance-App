import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ListVacationRequestsController extends GetxController {
  RxBool switchValue = false.obs;
  String searchValue = '';
  DateTime? start;
  DateTime end = DateTime.now();
  String? userName;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> vacationRequests() async* {
    yield* firestore
        .collection('vacationRequest')
        .where('status', isEqualTo: 'Pending')
        .snapshots();
  }

  changeSearchValue(String value) {
    searchValue = value;
    update();
  }

  void pickDate(DateTime pickStart, DateTime pickEnd) {
    start = pickStart;
    end = pickEnd;

    update();
    Get.back();
  }
}
