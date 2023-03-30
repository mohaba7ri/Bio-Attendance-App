import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllEmpsReportsController extends GetxController {
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getUserDate();
    await getCompanyData();
    await getBranchData();
  }

  dynamic userData = Get.arguments;
  final SharedPreferences sharedPreferences;
  AllEmpsReportsController({required this.sharedPreferences});
  List<List<dynamic>>? allPrecens;
  final firestore = FirebaseFirestore.instance;
  var startDateController = TextEditingController();
  var endDateController = TextEditingController();
  DateTime end = DateTime.now();
  DateTime? start;
  String userName = '';
  String? branchName;
  double totalSalary = 0;
  Map<String, dynamic>? company;
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

  // Future<List<List<dynamic>>> getData() async {
  //   QuerySnapshot<Map<String, dynamic>> snapshot = await getAllPresence();
  //   List<List<dynamic>> data = [];

  //   snapshot.docs.forEach((doc) {
  //     List<dynamic> row = [];
  //     row.add(
  //         DateFormat("M/d/yyyy").format(DateTime.parse(doc.data()["date"])));
  //     row.add(
  //         doc.data()["checkIn"] != null && doc.data()["checkIn"]["date"] != null
  //             ? DateFormat.jm()
  //                 .format(DateTime.parse(doc.data()["checkIn"]["date"]))
  //             : '');
  //     row.add(doc.data()["checkOut"] != null &&
  //             doc.data()["checkOut"]["date"] != null
  //         ? DateFormat.jm()
  //             .format(DateTime.parse(doc.data()["checkOut"]["date"]))
  //         : '');
  //     row.add(doc.data()['timing'] != null ? doc.data()['timing'] : '');
  //     row.add(doc.data()['status'] != null ? doc.data()['status'] : '');
  //     row.add(doc.data()['hoursWork'] != null ? doc.data()['hoursWork'] : '');

  //     data.add(row);
  //   });
  //   allPrecens = data;
  //   update();
  //   print('the all precens$data');
  //   return data;
  // }

  Future<List<List<dynamic>>> getData() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshots =
        await getAllPresence();
    List<List<dynamic>> data = [];

    snapshots.forEach((snapshot) {
      List<dynamic> row = [];
      row.add(snapshot.data()['name'] != null ? snapshot.data()['name'] : '');
      row.add(DateFormat("M/d/yyyy")
          .format(DateTime.parse(snapshot.data()["date"])));
      row.add(snapshot.data()["checkIn"] != null &&
              snapshot.data()["checkIn"]["date"] != null
          ? DateFormat.jm()
              .format(DateTime.parse(snapshot.data()["checkIn"]["date"]))
          : '');
      row.add(snapshot.data()["checkOut"] != null &&
              snapshot.data()["checkOut"]["date"] != null
          ? DateFormat.jm()
              .format(DateTime.parse(snapshot.data()["checkOut"]["date"]))
          : '');
      // row.add(
      //     snapshot.data()['timing'] != null ? snapshot.data()['timing'] : '');
      row.add(
          snapshot.data()['status'] != null ? snapshot.data()['status'] : '');
      row.add(snapshot.data()['hoursWork'] != null
          ? snapshot.data()['hoursWork']
          : '');

      data.add(row);
    });

    print('the all precens$data');
    allPrecens = data;
    return data;
  }

  Future<double> calculateTotalSalary() async {
    List<List<dynamic>> data = await getData();

    data.forEach(
      (row) {
        if (row.length >= 6 && row[5] != null && row[5] != '') {
          List<String> hoursAndMinutes = row[5].split(':');
          if (hoursAndMinutes.length == 2) {
            int hours = int.parse(hoursAndMinutes[0]);
            int minutes = int.parse(hoursAndMinutes[1]);
            double hoursWorked = hours + (minutes / 60);
            totalSalary += hoursWorked * 750;
          }
        }
      },
    );

    return totalSalary;
  }

  // Future<QuerySnapshot<Map<String, dynamic>>> getAllPresence() async {
  //   String? uid = sharedPreferences.getString('userId');
  //   QuerySnapshot<Map<String, dynamic>>? query;
  //   try {
  //     if (startDateController == null) {
  //       query = await firestore
  //           .collection("user")
  //           .doc(uid)
  //           .collection("presence")
  //           .where("date", isLessThan: end.toIso8601String())
  //           .orderBy(
  //             "date",
  //             descending: true,
  //           )
  //           .get();

  //       return query;
  //     } else {
  //       QuerySnapshot<Map<String, dynamic>> query = await firestore
  //           .collection("user")
  //           .doc(uid)
  //           .collection("presence")
  //           .where("date", isGreaterThan: start!.toIso8601String())
  //           .where("date",
  //               isLessThan: end.add(Duration(days: 1)).toIso8601String())
  //           .orderBy(
  //             "date",
  //             descending: true,
  //           )
  //           .get();
  //       return query;
  //     }
  //   } catch (e) {
  //     print('error $e');
  //   }
  //   return query!;
  // }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getAllPresence() async {
    QuerySnapshot<Map<String, dynamic>>? query;
    try {
      query = await firestore.collection("user").get();

      List<Future<QuerySnapshot<Map<String, dynamic>>>> futures = [];
      for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in query.docs) {
        futures.add(firestore
            .collection("user")
            .doc(documentSnapshot.id)
            .collection("presence")
            .where("date", isGreaterThan: start!.toIso8601String())
            .where("date",
                isLessThan: start!.add(Duration(days: 1)).toIso8601String())
            .orderBy(
              "date",
              descending: true,
            )
            .get());
      }
      List<QuerySnapshot<Map<String, dynamic>>> snapshots =
          await Future.wait(futures);
      List<QueryDocumentSnapshot<Map<String, dynamic>>> documents = [];
      for (QuerySnapshot<Map<String, dynamic>> snapshot in snapshots) {
        documents.addAll(snapshot.docs);
      }
      return documents;
    } catch (e) {
      print('error $e');
      return [];
    }
  }

  Future getUserDate() async {
    String? userId = sharedPreferences.getString('userId');
    await firestore.collection('user').doc(userId).get().then((data) {
      userName = data['name'];
      print('the user Name$userName');
    });
    update();
  }

  Future getCompanyData() async {
    await firestore.collection('company').get().then((query) {
      query.docs.forEach((data) {
        company = data.data();
      });
    });
  }

  Future getBranchData() async {
    await firestore
        .collection('branch')
        .doc(userData['branchId'])
        .get()
        .then((data) {
      branchName = data['name'];
    });
  }
}
