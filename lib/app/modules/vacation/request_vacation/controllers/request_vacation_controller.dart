import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../../../../widgets/toast/custom_toast.dart';
import '../../../home/controllers/home_controller.dart';

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
  String? superAdminToken;
  RxBool isPrevious = false.obs;
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
    await returnVacationType();
    await getSuperAdmin();
    await getPreviousRequest();
    await getUserData();
    await getAdminData();
  }

  changeLeaveType(value) {
    leaveTypeValue = value;
    update();
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

  Future uploadFile() async {
    // setState(() => file = File(path));
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
    );

    if (result == null) {
      print('error');
      return null;
    }
    filePath = result.files.single.path;
    fileName = result.files.single.name;
    fileController.value.text = fileName!;
    // fileController.value = fileName;
    print('the file name${fileName}');
  }

  Future returnVacationType() async {
    final leaveTypeStore = await FirebaseFirestore.instance
        .collection('vacationType')
        .where('vacationStatus', isEqualTo: 'active');

    leaveTypeStore.get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data();
        vacationTypeList.add(DropdownMenuItem(
          child: Text(data['vacationType']),
          value: data['vacationType'],
        ));
        update();
      });
    });
  }

  Future<void> storeFile(
    String filePath,
    String fileName,
  ) async {
    isloading!.value = true;
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('vacationRequest/$fileName');
    await ref.putFile(File(filePath));
    vacationUrl = await ref.getDownloadURL();
  }

  void submit() async {
    int? selectedDays = int.parse(daysController.value.text);
    if (leaveTypeValue == null) {
      CustomToast.errorToast('please_select_leave_type'.tr);
    } else if (selectedDays > vacationDays!) {
      CustomToast.errorToast('you_exceeded_the_allowed_days_number'.tr);
    } else if (formKey.currentState!.validate()) {
      print('isPrevios${isPrevious.value}');
      if (isPrevious.value == true) {
        CustomToast.errorToast(
            title: 'sorry'.tr,
            'you_cannot'.tr);
      } else {
        if (filePath != null) {
          await storeFile(filePath!, fileName!)
              .whenComplete(() => storeVacationData());
        } else {
          await storeVacationData();
        }
      }
    }
  }

  changeVacationValue(value) async {
    leaveTypeValue = value;
    update();
    await firebase
        .collection('vacationType')
        .where('vacationType', isEqualTo: leaveTypeValue)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data();
        vacationDays = int.parse(data['vacationDays']);
        print('the vacation Days$vacationDays');
        update();
      });
    });
  }

  Future storeVacationData() async {
    String uid = sharedPreferences.getString('userId')!;
    isloading!.value = true;
    String vacationId = const Uuid().v4();
    // parse the date string to a DateTime object
    DateTime startDate =
        DateFormat("MMM d, y").parse(startDateController.value.text);

    DateTime endDate =
        DateFormat("MMM d, y").parse(endDateController.value.text);
// format the DateTime object to the desired string format
    String formatEedDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSSSS").format(endDate);
    String formatStartDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSSSS").format(startDate);

    await firebase.collection('vacationRequest').doc(vacationId).set({
      'vacationId': vacationId,
      'vacationType': leaveTypeValue,
      'startDate': formatStartDate,
      'endDate': formatEedDate,
      'requestDate': DateTime.now().toIso8601String(),
      'userId': uid,
      'userName': userName,
      'vacationNum': 1,
      'days': daysController.value.text,
      'file': vacationUrl,
      'status': 'Pending',
      'branchId': branchId
    }).whenComplete(() async {
      String userDevice = sharedPreferences.getString('deviceToken')!;
      String adminToken;

      storeNotefications(
          adminDeviceToken:
              userRole == 'Admin' ? superAdminToken : adminDeviceToken,
          body: userName,
          docId: vacationId,
          title: 'vacation_request_by'.tr,
          userDeviceToken: userDevice);
      isloading!.value = false;
      fileName = '';
      filePath = '';

      fileController.value.text = ' ';
      CustomToast.successToast('your_request_sent_successfully'.tr);
    });
  }

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
      });
    } catch (e) {}
  }

  void calculateDays() {
    if (startDateController.value.text.isNotEmpty &&
        endDateController.value.text.isNotEmpty) {
      final startDate =
          DateFormat.yMMMd().parse(startDateController.value.text);
      final endDate = DateFormat.yMMMd().parse(endDateController.value.text);
      final days = endDate.difference(startDate).inDays + 1;
      daysController.value.text = days.toString();
      print("the days${daysController.value.text}");
    }
  }

  Future<DateTime?> showDatePickers(
      BuildContext context, String initialDateString) async {
    var initialDate = DateTime.now();
    if (initialDateString.isNotEmpty) {
      try {
        initialDate = DateFormat.yMMMd().parse(initialDateString);
      } catch (e) {
        print(e);
      }
    }
    final date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    return date;
  }

  startDayValdate() {
    if (startDateController.value.text.isEmpty) {
      return 'pick date';
    }
  }

  Future getSuperAdmin() async {
    try {
      await firebase
          .collection('user')
          .where('role', isEqualTo: 'SuperAdmin')
          .get()
          .then((query) {
        query.docs.forEach((doc) {
          Map<String, dynamic> data = doc.data();
          print('super:${data['name']}');
          superAdminToken = data['deviceToken'];
          update();
        });
      });
    } catch (e) {
      print('error is$e');
    }
  }

  Future getPreviousRequest() async {
    DateTime end = DateTime.now();
    try {
      await firebase
          .collection('vacationRequest')
          .where('userId', isEqualTo: sharedPreferences.getString('userId'))
          .where("status", isEqualTo: "Approved")
          .where("endDate",
              isGreaterThanOrEqualTo: DateTime.now().toIso8601String())
          .limit(1)
          .orderBy(
            "endDate",
            descending: true,
          )
          .get()
          .then((doc) {
        if (doc.docs.isEmpty) {
          isPrevious.value = false;
        } else {
          doc.docs.forEach((data) {
            print('the reQuestVacationData${data.data()} ');
          });
          isPrevious.value = true;
        }
      });
    } catch (e) {
      print('the problem $e');
    }
  }
}
