import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presence/app/widgets/custom_input.dart';

import '../controllers/add_vacation_type_controller.dart';

class AddVacationTypeView extends GetView<AddVacationTypeController> {
  @override
  final presenceController = Get.put(AddVacationTypeController());
  Widget build(BuildContext context) {
    //  AddVacationTypeController controller = AddVacationTypeController();
    // TODO: implement build

    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
            child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            SizedBox(
              height: 5,
            ),
            Center(
              child: Container(
                width: 38,
                child: Divider(
                  thickness: .6,
                  color: Color(0xff008BC5),
                ),
              ),
            ),
            Center(
              child: Container(
                height: 5,
                width: 23,
                child: Divider(
                  thickness: .6,
                  color: Color(0xff008BC5),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "add_vacation_type".tr,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff008BC5)),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: CustomInput(
                  controller: controller.vacationType.value,
                  label: 'vacation_type'.tr,
                  hint: 'sick'.tr),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: CustomInput(
                  controller: controller.vacationDays.value,
                  label: 'vacation_days'.tr,
                  hint: '1'),
            ),
            SizedBox(
              height: 10,
            ),
            Obx(() => Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('status'.tr),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: DropdownButton(
                                alignment: Alignment.center,
                                value: controller.vacationStatus.value,
                                items: controller.vacationStatusItems
                                    .map((String items) {
                                  return DropdownMenuItem(
                                    alignment: AlignmentDirectional.center,
                                    child: Text(items),
                                    value: items,
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  controller.changeStatusValue(value!);
                                }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('Cancel'.tr),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.red.shade400)),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.stroreVacationType();
                  },
                  child: Text('Save'.tr),
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                          Colors.teal.shade400)),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
          ]),
        )),
      ),
    );

    // Scaffold(
    //   appBar: AppBar(
    //     title: Text('Add Vacation Type'),
    //     backgroundColor: Colors.teal.shade600,
    //   ),
    //   body:

    //   Padding(
    //     padding: const EdgeInsets.only(top: 20),
    //     child: ListView(
    //       children: [
    //         CustomInput(
    //           controller: controller.vacationType.value,
    //           label: 'Vacation Type',
    //           hint: 'Vacation Type',
    //         ),
    //         Obx(
    //           () => controller.isPaid.value == false
    //               ? SizedBox()
    //               : CustomInput(
    //                   type: TextInputType.number,
    //                   controller: controller.vacationDays.value,
    //                   label: 'Vacation Days',
    //                   hint: 'Vacation Days',
    //                 ),
    //         ),
    //         Obx(
    //           () => Row(
    //             children: [
    //               Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text('Status'),
    //                   SizedBox(
    //                     width: MediaQuery.of(context).size.width * 0.4,
    //                     child: DropdownButton(
    //                         alignment: Alignment.center,
    //                         value: controller.vacationStatus.value,
    //                         items: controller.vacationStatusItems
    //                             .map((String items) {
    //                           return DropdownMenuItem(
    //                             child: Text(items),
    //                             value: items,
    //                           );
    //                         }).toList(),
    //                         onChanged: (String? value) {
    //                           controller.changeStatusValue(value!);
    //                         }),
    //                   ),
    //                 ],
    //               ),
    //               Spacer(),
    //               Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text('Is Paid Vacation'),
    //                   SizedBox(
    //                     width: MediaQuery.of(context).size.width * 0.4,
    //                     child: DropdownButton(
    //                         value: controller.isPaidValue.value,
    //                         items: controller.isPaidItems.map((String items) {
    //                           return DropdownMenuItem(
    //                             child: Text(items),
    //                             value: items,
    //                           );
    //                         }).toList(),
    //                         onChanged: (String? value) {
    //                           controller.changeIsPaidValue(value!);
    //                           controller.changeIsPaid();
    //                         }),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),

    // );
  }
}
