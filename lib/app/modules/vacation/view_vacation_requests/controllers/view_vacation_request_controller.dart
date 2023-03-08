import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../home/controllers/home_controller.dart';

class ViewVacationRequestsController extends GetxController {
  final homeController = Get.find<HomeController>();
  RxBool switchValue = false.obs;
  String searchValue = '';
  DateTime? start;
  DateTime end = DateTime.now();
  String? userName;
  String? vacationId;
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

  Future accept(String docId) async {
    try {
      await firestore
          .collection('vacationRequest')
          .doc(docId)
          .update({'status': "Approved"});
    } catch (e) {
      print('the error$e');
    }
  }

  Future deny(String docId) async {
    try {
      await firestore
          .collection('vacationRequest')
          .doc(docId)
          .update({'status': "Denied"});
      update();
    } catch (e) {
      print('the error$e');
    }
  }

  Future getNotefication(String? docId, String status) async {
    await firestore
        .collection('notefications')
        .doc(docId)
        .get()
        .then((query) async {
      Map<String, dynamic> data = query.data() as Map<String, dynamic>;
      String userDeviceToken = data['userDeviceToken'];
      String title = 'Your Vacation has been : \n';
      homeController.sendPushMessage(userDeviceToken, status, title);
    });
  }
}
