import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AttendanceController extends GetxController {
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUsers();
  }

  int? PresentNumber;

  var firestore = FirebaseFirestore.instance;

  String? username;
  // A list of months to display in the dropdown menu
  final months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  // The currently selected month (defaults to the current month)
  var selectedMonth = DateTime.now().month.obs;

  // The total number of hours worked for the selected month
  var totalHours = 0.obs;

  // The number of hours the user was late for the selected month
  var lateHours = 0.obs;

  // The user's hourly rate
  final hourlyRate = 10.0;

  // A function to calculate the user's salary based on the total hours worked
  double get salary => totalHours.value * hourlyRate;

  // Future getUsers() async {
  //   await firestore
  //       .collection('user')
  //       .where("present", isEqualTo: true)
  //       .get()
  //       .then((QuerySnapshot query) {
  //     PresentNumber = query.size;

  //     print('number of presence$PresentNumber');
  //     update();
  //   });
  // }

  Future<void> getUsers() async {
    final querySnapshot = await firestore.collection('user').get();

    PresentNumber = querySnapshot.size;

    print('number of presence$PresentNumber');
    update();
  }
}
