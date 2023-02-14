import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:presence/app/modules/home/controllers/home_controller.dart';

import '../../../../widgets/toast/custom_toast.dart';

class VacationRequestController extends GetxController {
  var homeController = HomeController();
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
  String? branchName;
  String? adminDeviceToken;
  // FilePickerResult? vacationFile;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  RxString leaveTypeValue = 'please select'.obs;

  final vacationTypeList = <DropdownMenuItem<String>>[].obs;

  CollectionReference vacationRequest =
      FirebaseFirestore.instance.collection('vacationRequest');
  CollectionReference leaveTypeStore =
      FirebaseFirestore.instance.collection('vacationType');
  CollectionReference user = FirebaseFirestore.instance.collection('user');

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getUserData();
    await getAdminData();

    returnVacationType();
  }

  Future getUserData() async {
    try {
      await user.doc(uid).get().then((query) {
        Map<String, dynamic> data = query.data() as Map<String, dynamic>;
        userName = data['name'];

        update();
      });
    } catch (e) {}
  }

  Future getAdminData() async {
    print('heloooooo');
    try {
      await user
          .where('role', isEqualTo: 'Admin')
          .where('branchName', isEqualTo: branchName)
          .get()
          .then((query) {
        query.docs.forEach((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
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

  void returnVacationType() {
    final leaveTypeStore = FirebaseFirestore.instance
        .collection('vacationType')
        .where('vacationStatus', isEqualTo: 'active');

    leaveTypeStore.get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data();
        vacationTypeList.add(DropdownMenuItem(
          child: Text(data['vacationType']),
          value: data['vacationType'],
        ));
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
    if (leaveTypeValue.value == 'please select') {
      CustomToast.errorToast('please select leave type');
    } else if (formKey.currentState!.validate()) {
      if (filePath != null) {
        await storeFile(filePath!, fileName!)
            .whenComplete(() => storeVacationData());
      } else {
        await storeVacationData();
      }
    }
  }

  Future storeVacationData() async {
    isloading!.value = true;

    await vacationRequest.doc().set({
      'vacationId': 'uid',
      'vacationType': leaveTypeValue.value,
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
      await homeController.sendPushMessage(
          adminDeviceToken!, userName!, 'Vacation Request by:');
      isloading!.value = false;
      fileName = '';
      filePath = '';
      leaveTypeValue.value = 'please select';
      fileController.value.text = ' ';
      CustomToast.successToast('your_request_sent_successfully');
    });
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

  Future<DateTime> showDatePickers(
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

    return date!;
  }

  startDayValdate() {
    if (startDateController.value.text.isEmpty) {
      return 'pick date';
    }
  }

  changeLeaveValue(String value) {
    leaveTypeValue.value = value;
  }
}
