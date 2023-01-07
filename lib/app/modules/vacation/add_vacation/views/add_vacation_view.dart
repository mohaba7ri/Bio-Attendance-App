import 'package:flutter/material.dart';
import 'package:presence/app/modules/vacation/add_vacation/controllers/add_vacation_controller.dart';
import 'package:presence/app/widgets/custom_input.dart';
import 'package:get/get.dart';

class AddVacationTypeView extends GetView<AddVacationTypeController> {
  @override
  Widget build(BuildContext context) {
    //  AddVacationTypeController controller = AddVacationTypeController();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Vacation Type'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView(
          children: [
            CustomInput(
              controller: controller.vacationType,
              label: 'Vacation Type',
              hint: 'Vacation Type',
            ),
            Obx(
              () => controller.isPaid == false
                  ? SizedBox()
                  : CustomInput(
                      type: TextInputType.number,
                      controller: controller.vacationType,
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
                            value: controller.statusValue.value,
                            items: controller.statusItems.map((String items) {
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
                            value: controller.isPiadValue.value,
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
