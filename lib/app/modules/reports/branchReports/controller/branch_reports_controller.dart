import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BranchReportsController extends GetxController {
  dynamic branchList = Get.arguments;

  final startDateController = TextEditingController().obs;
  final endDateController = TextEditingController().obs;
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
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    return date!;
  }

  startDayValdate() {
    var startDateController;
    if (startDateController.value.text.isEmpty) {
      return 'pick date';
    }
  }
}
