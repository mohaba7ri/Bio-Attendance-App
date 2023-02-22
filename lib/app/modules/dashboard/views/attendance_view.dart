import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../style/app_color.dart';
import '../controllers/attendance_controller.dart';

class AttendanceView extends GetView<AttendanceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 20,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColor.greyColor),
        )
//  Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Display the user's name (replace with actual user data)
//             Text('User Name'),

//             SizedBox(height: 16.0),

//             // Dropdown menu to select the month
//             Obx(() => DropdownButton<int>(
//                   value: controller.selectedMonth.value,
//                   items: controller.months
//                       .asMap()
//                       .entries
//                       .map((entry) => DropdownMenuItem(
//                             value: entry.key + 1,
//                             child: Text(entry.value),
//                           ))
//                       .toList(),
//                   onChanged: (value) {
//                     controller.selectedMonth.value = value!;
//                     // TODO: update total hours and late hours based on selected month
//                   },
//                 )),

//             SizedBox(height: 16.0),

//             // Display the total hours worked for the selected month
//             Obx(() => Text('Total Hours: ${controller.totalHours.value}')),

//             SizedBox(height: 16.0),

//             // Display the number of hours the user was late for the selected month
//             Obx(() => Text('Late Hours: ${controller.lateHours.value}')),

//             SizedBox(height: 16.0),

//             // Display the user's salary based on the total hours worked
//             Obx(() =>
//                 Text('Salary: \$${controller.salary.toStringAsFixed(2)}')),
//           ],
//         ),
//       ),

        );
  }
}
