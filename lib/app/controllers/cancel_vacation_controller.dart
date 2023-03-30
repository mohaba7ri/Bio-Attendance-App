import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../modules/home/controllers/home_controller.dart';
import '../widgets/toast/custom_toast.dart';

class VacationRequestController extends GetxController {
  final SharedPreferences sharedPreferences;
  VacationRequestController({required this.sharedPreferences});
  var homeController = HomeController(sharedPreferences: Get.find());
  final formKey = GlobalKey<FormState>();
  final startDateController = TextEditingController().obs;
  final endDateController = TextEditingController().obs;
  final daysController = TextEditingController().obs;
  final fileController = TextEditingController().obs;
  RxBool? isloading = false.obs;
  String? fileName;
  String? filePath;
  String? vacationUrl = 'No file';
  String? userName;
  String? branchId;
  String? adminDeviceToken;
  String? userRole;
  DateTime date = DateTime.now();
  // FilePickerResult? vacationFile;

  String? leaveTypeValue;
  int? vacationDays;

  final vacationTypeList = <DropdownMenuItem<String>>[];

  var firebase = FirebaseFirestore.instance;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    await getUserData();
    await getAdminData();
  }

  Future getUserData() async {
    String uid = sharedPreferences.getString('userId')!;
    try {
      await firebase.collection('user').doc(uid).get().then((query) {
        Map<String, dynamic> data = query.data() as Map<String, dynamic>;
        userName = data['name'];
        userRole = data['role'];
        branchId = data['branchId'];

        update();
      });
    } catch (e) {}
  }

  Future getAdminData() async {
    try {
      await firebase
          .collection('user')
          .where('role', isEqualTo: 'Admin')
          .where('branchId', isEqualTo: branchId)
          .get()
          .then((query) {
        query.docs.forEach((doc) {
          Map<String, dynamic> data = doc.data();
          print('Admin:${data['name']}');
          adminDeviceToken = data['deviceToken'];
          print('Admin token$adminDeviceToken');
          update();
        });
      });
    } catch (e) {
      print('error is$e');
    }
  }

  Future storeVacationData() async {
    String uid = sharedPreferences.getString('userId')!;
    isloading!.value = true;
    String vacationId = const Uuid().v4();
    await firebase.collection('CancelRequest').doc(vacationId).set({
      'vacationId': vacationId,
      'vacationType': leaveTypeValue,
      'startDate': startDateController.value.text,
      'endDate': endDateController.value.text,
      'requestDate': DateTime.now().toIso8601String(),
      'userId': uid,
      'userName': userName,
      'vacationNum': 1,
      'days': daysController.value.text,
      'file': vacationUrl,
      'status': 'Pending',
      'cancelled': '',
    }).whenComplete(() async {
      String userDevice = sharedPreferences.getString('deviceToken')!;
      storeNotefications(
          adminDeviceToken: adminDeviceToken,
          body: userName,
          docId: vacationId,
          title: 'cancel_request_by'.tr,
          userDeviceToken: userDevice);
      isloading!.value = false;
      fileName = '';
      filePath = '';

      fileController.value.text = ' ';
      CustomToast.successToast('your_request_sent_successfully'.tr);
    });
  }

// sendno async {
//       String userDevice = sharedPreferences.getString('deviceToken')!;
//       storeNotefications(
//           adminDeviceToken: adminDeviceToken,
//           body: userName,
//           docId: vacationId,
//           title: 'vacation_request_by'.tr,
//           userDeviceToken: userDevice);
//       isloading!.value = false;
//       fileName = '';
//       filePath = '';

//       fileController.value.text = ' ';
//       CustomToast.successToast('your_request_sent_successfully'.tr);
//     });

  String _noteficationId = const Uuid().v4();
  Future storeNotefications(
      {String? adminDeviceToken,
      String? userDeviceToken,
      String? body,
      String? docId,
      String? title}) async {
    try {
      await homeController.sendPushMessage(
          adminDeviceToken!, userName!, 'vacation_request_by'.tr);
      await firebase.collection('notefications').doc(docId).set({
        'body': body,
        'userDeviceToken': userDeviceToken,
        'title': title,
        'adminDeviceToken': adminDeviceToken,
        'date': date
      }).whenComplete(() async {});
    } catch (e) {}
  }
}
