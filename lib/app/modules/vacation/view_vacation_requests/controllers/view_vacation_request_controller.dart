import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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

  Future accept(data) async {
    final inputString = data['startDate'];
    final inputFormat = DateFormat('MMM dd, yyyy');
    final outputFormat = DateFormat('M-d-yyyy');

    final inputDate = inputFormat.parse(inputString);
    final outputString = outputFormat.format(inputDate);

    final startDate = inputDate;
    final endDate = inputFormat.parse(data['endDate']);

    final duration = endDate.difference(startDate);
    final numberOfDays = duration.inDays + 1; // add 1 to include the end day

    try {
      await firestore
          .collection('vacationRequest')
          .doc(data['vacationId'])
          .update({'status': "Approved"});

      // Loop through each day in the vacation period and create a new document
      // in the presence collection for that day
      for (var i = 0; i < numberOfDays; i++) {
        final date = startDate.add(Duration(days: i));
        String formattedDate =
            DateFormat('yyyy-MM-ddTHH:mm:ss.SSSSSS').format(date);
        final dateString = outputFormat.format(date);

        await firestore
            .collection('user')
            .doc(data['userId'])
            .collection('presence')
            .doc(dateString)
            .set({
          'name': data['userName'],
          'date': formattedDate,
          'status': 'onVacation',
          // 'checkIn': {
          //   'address': '',
          //   'date': '',
          //   'distance': '',
          //   'in_area': '',
          //   'latitude': '',
          //   'longitude': '',
          // },
          'hoursWork': '0',
        });
      }
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
      print('$userDeviceToken');
      String title = 'Your Vacation has been : \n';
      homeController.sendPushMessage(userDeviceToken, status, title);
    });
  }
}
