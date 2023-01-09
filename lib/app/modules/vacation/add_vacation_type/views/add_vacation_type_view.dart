import 'package:flutter/material.dart';

import 'package:presence/app/widgets/custom_input.dart';
import 'package:get/get.dart';

import '../controllers/add_vacation_type_controller.dart';

class AddVacationTypeView extends GetView<AddVacationTypeController> {
  @override
  Widget build(BuildContext context) {
    //  AddVacationTypeController controller = AddVacationTypeController();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Vacation Type'),
        backgroundColor: Colors.teal.shade600,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView(
          children: [
            CustomInput(
              controller: controller.vacationType.value,
              label: 'Vacation Type',
              hint: 'Vacation Type',
            ),
            Obx(
              () => controller.isPaid.value == false
                  ? SizedBox()
                  : CustomInput(
                      type: TextInputType.number,
                      controller: controller.vacationDays.value,
                      label: 'Vacation Days',
                      hint: 'Vacation Days',
                    ),
            ),
            Obx(
              () => Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Status'),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: DropdownButton(
                            alignment: Alignment.center,
                            value: controller.vacationStatus.value,
                            items: controller.vacationStatusItems
                                .map((String items) {
                              return DropdownMenuItem(
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
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Is Paid Vacation'),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: DropdownButton(
                            value: controller.isPaidValue.value,
                            items: controller.isPaidItems.map((String items) {
                              return DropdownMenuItem(
                                child: Text(items),
                                value: items,
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              controller.changeIsPaidValue(value!);
                              controller.changeIsPaid();
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
