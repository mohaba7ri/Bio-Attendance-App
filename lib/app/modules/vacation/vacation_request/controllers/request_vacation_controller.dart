import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class VacationRequestController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final startDateController = TextEditingController().obs;
  final endDateController = TextEditingController().obs;
  final daysController = TextEditingController().obs;
  final fileController = TextEditingController().obs;
  RxBool? isloading = false.obs;
  String? fileName;
  String? filePath;
  String? vacationUrl;
  // FilePickerResult? vacationFile;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  RxString leaveTypeValue = 'please select'.obs;
  var leaveType = ['please select', 'sick', 'causal'];
  CollectionReference vacationRequest =
      FirebaseFirestore.instance.collection('vacationrequest');
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
    if (formKey.currentState!.validate()) {
      if (filePath != null) {
        await storeFile(filePath!, fileName!)
            .whenComplete(() => storeVacationData());
      }
    }
  }

  void storeVacationData() {
    vacationRequest.doc().set({
      'vacationid': 'uid',
      'leavetype': leaveTypeValue.value,
      'startday': startDateController.value.text,
      'endday': endDateController.value.text,
      'requestday': DateTime.now().toIso8601String(),
      'userid': uid,
      'vacationnum': 1,
      'days': daysController.value.text,
      'file': vacationUrl,
      'status': '',
      'cancelledd': '',
    }).whenComplete(() {
      isloading!.value = false;
      fileName = '';
      filePath = '';
      leaveTypeValue.value = 'please select';
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
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    return date!;
  }

  startDayValdate() {
    if (startDateController.value.text.isEmpty) {
      return 'fuck pick date';
    }
  }

  changeLeaveValue(String value) {
    leaveTypeValue.value = value;
  }
}
