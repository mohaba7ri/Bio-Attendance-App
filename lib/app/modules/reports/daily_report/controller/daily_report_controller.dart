import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyReportController extends GetxController {
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getUserDate();
    await getCompanyData();
    await getBranchData();
    await getBranches();
  }

  dynamic userData = Get.arguments;
  final SharedPreferences sharedPreferences;
  DailyReportController({required this.sharedPreferences});
  List<List<dynamic>>? allPrecens;
  final firestore = FirebaseFirestore.instance;
  var startDateController = TextEditingController();
  var endDateController = TextEditingController();
  DateTime end = DateTime.now();
  DateTime? start;
  String userName = '';
  dynamic salary;
  dynamic totalHoursWork;
  String? branchValue;
  String? branchId;
  String? branchName;
  final branchesList = <DropdownMenuItem<String>>[].obs;

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

  Future getBranchData() async {
    await firestore
        .collection('branch')
        .doc(userData['branchId'])
        .get()
        .then((data) {
      branchName = data['name'];
    });
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

  changeBranchValue(value) async {
    branchValue = value;
    update();
    await firestore
        .collection('branch')
        .where('name', isEqualTo: branchValue)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data();
        branchId = data['branchId'];
        update();
      });
    });
  }

  Future getBranches() async {
    final branches = FirebaseFirestore.instance.collection('branch');
    try {
      await branches.get().then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          Map<String, dynamic> data = doc.data();

          branchesList.add(
            DropdownMenuItem(
              child: Text(data['name']),
              value: data['name'],
            ),
          );
          update();
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

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
      row.add(
          snapshot.data()['timing'] != null ? snapshot.data()['timing'] : '');
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
            double userSalary = double.tryParse(salary) ?? 0.0;

            totalSalary += hoursWorked * userSalary;
          }
        }
      },
    );

    return totalSalary;
  }

  Future calculateTotalHoursWork() async {
    List<List<dynamic>> data = await getData();
    Duration totalDuration = Duration();

    data.forEach(
      (row) {
        if (row.length >= 6 && row[5] != null && row[5] != '') {
          List<String> hoursAndMinutes = row[5].split(':');
          if (hoursAndMinutes.length == 2) {
            int hours = int.parse(hoursAndMinutes[0]);
            int minutes = int.parse(hoursAndMinutes[1]);
            //  double hoursWorked = hours + (minutes / 60);

            Duration duration = Duration(hours: hours, minutes: minutes);
            totalDuration += duration;
          }
        }
      },
    );
    String hours = totalDuration.inHours.toString().padLeft(2, '0');
    String minutes =
        (totalDuration.inMinutes.remainder(60)).toString().padLeft(2, '0');
    totalHoursWork = '$hours:$minutes';

    print('Total hours worked: $totalHoursWork');

    return totalHoursWork;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getAllPresence() async {
    QuerySnapshot<Map<String, dynamic>>? query;
    try {
      if (userData['role'] == 'SuperAdmin') {
        query = await firestore
            .collection("user")
            .where('branchId', isEqualTo: branchId)
            .get();
      } else {
        query = await firestore
            .collection("user")
            .where('branchId', isEqualTo: userData['branchId'])
            .get();
      }

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
      salary = data['salaryPerHour'];

      print('the user Name$userName');
      print('the user salay $salary');
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
}
