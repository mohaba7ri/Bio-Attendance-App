import 'package:get/get.dart';

class AttendanceController extends GetxController {
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
}
