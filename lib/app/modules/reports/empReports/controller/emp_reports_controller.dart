import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EmpReportsController extends GetxController {
  dynamic user = Get.arguments;

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    user = '';
  }

  List<List<dynamic>>? allPrecens;
  final firestore = FirebaseFirestore.instance;
  var startDateController = TextEditingController();
  var endDateController = TextEditingController();
  DateTime end = DateTime.now();
  DateTime? start;
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

  changeStartDate(startDate) {
    update();

    startDateController =
        TextEditingController(text: DateFormat.yMMMd().format(startDate!));
    start = startDate;

    print('start$start');
  }

  changeEndDate(endDate) {
    update();
    endDateController =
        TextEditingController(text: DateFormat.yMMMd().format(endDate));
    end = endDate;
  }

  startDayValdate() {
    var startDateController;
    if (startDateController.value.text.isEmpty) {
      return 'pick date';
    }
  }

  // Future<QuerySnapshot<Map<String, dynamic>>> getAllPresence() async {
  //   String uid = user['userId'];
  //   if (startDateController == null) {
  //     QuerySnapshot<Map<String, dynamic>> query = await firestore
  //         .collection("user")
  //         .doc(uid)
  //         .collection("presence")
  //         .where("date", isLessThan: end.toIso8601String())
  //         .orderBy(
  //           "date",
  //           descending: true,
  //         )
  //         .get();
  //     return query;
  //   } else {
  //     QuerySnapshot<Map<String, dynamic>> query = await firestore
  //         .collection("user")
  //         .doc(uid)
  //         .collection("presence")
  //         .where("date", isGreaterThan: start!.toIso8601String())
  //         .where("date",
  //             isLessThan: end.add(Duration(days: 1)).toIso8601String())
  //         .orderBy(
  //           "date",
  //           descending: true,
  //         )
  //         .get();
  //     return query;
  //   }
  // }

  Future<List<List<dynamic>>> getData() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await getAllPresence();
    List<List<dynamic>> data = [];

    snapshot.docs.forEach((doc) {
      List<dynamic> row = [];
      row.add(
          DateFormat("M/d/yyyy").format(DateTime.parse(doc.data()["date"])));
      row.add(
          doc.data()["checkIn"] != null && doc.data()["checkIn"]["date"] != null
              ? DateFormat.jm()
                  .format(DateTime.parse(doc.data()["checkIn"]["date"]))
              : '');
      row.add(doc.data()["checkOut"] != null &&
              doc.data()["checkOut"]["date"] != null
          ? DateFormat.jm()
              .format(DateTime.parse(doc.data()["checkOut"]["date"]))
          : '');
      row.add(doc.data()['checkIn'] != null &&
              doc.data()['checkIn']['in_area'] != null
          ? doc.data()['checkIn']['in_area']
          : '');

      data.add(row);
    });
    allPrecens = data;
    update();
    print('the all precens$data');
    return data;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllPresence() async {
    String uid = user['userId'];
    QuerySnapshot<Map<String, dynamic>>? query;
    try {
      if (startDateController == null) {
        query = await firestore
            .collection("user")
            .doc(uid)
            .collection("presence")
            .where("date", isLessThan: end.toIso8601String())
            .orderBy(
              "date",
              descending: true,
            )
            .get();

        return query;
      } else {
        QuerySnapshot<Map<String, dynamic>> query = await firestore
            .collection("user")
            .doc(uid)
            .collection("presence")
            .where("date", isGreaterThan: start!.toIso8601String())
            .where("date",
                isLessThan: end.add(Duration(days: 1)).toIso8601String())
            .orderBy(
              "date",
              descending: true,
            )
            .get();
        return query;
      }
    } catch (e) {
      print('error $e');
    }
    return query!;
  }
}
