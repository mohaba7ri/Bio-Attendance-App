import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presence/app/widgets/custom_input.dart';

import '../controllers/request_vacation_controller.dart';

class RequestVacationView extends GetView<VacationRequestController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading:
            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_outlined)),
        title: Text('Vacation Request', style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Obx(
            () => Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Leave type'),
                        Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: DropdownButton(
                              value: controller.leaveTypeValue.value,
                              items: controller.leaveType.map((String items) {
                                return DropdownMenuItem(
                                  child: Text(items),
                                  value: items,
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                controller.changeLeaveValue(value!);
                              }),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Start date'),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: CustomInput(
                              valdate: (value) {
                                if (value!.isEmpty) {
                                  return 'please start date';
                                }
                                return null;
                              },
                              controller: controller.startDateController.value,
                              label: '',
                              hint: 'pick start date',
                              suffixIcon: IconButton(
                                  onPressed: () async {
                                    DateTime startDate =
                                        await controller.showDatePickers(
                                            context,
                                            controller.startDateController.value
                                                .text);
                                    controller.startDateController.value =
                                        TextEditingController(
                                            text: DateFormat.yMMMd()
                                                .format(startDate));
                                  },
                                  icon: Icon(Icons.date_range)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('End date'),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: CustomInput(
                              valdate: (value) {
                                if (value!.isEmpty) {
                                  return 'please pick end date';
                                }
                                return null;
                              },
                              controller: controller.endDateController.value,
                              label: '',
                              hint: 'pick End date',
                              suffixIcon: IconButton(
                                  onPressed: () async {
                                    DateTime startDate =
                                        await controller.showDatePickers(
                                            context,
                                            controller
                                                .endDateController.value.text);
                                    controller.endDateController.value =
                                        TextEditingController(
                                            text: DateFormat.yMMMd()
                                                .format(startDate));
                                    controller.calculateDays();
                                  },
                                  icon: Icon(Icons.date_range)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Days '),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: CustomInput(
                              disabled: true,
                              controller: controller.daysController.value,
                              label: '',
                              hint: '0',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('File '),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: CustomInput(
                              disabled: true,
                              controller: controller.fileController.value,
                              label: '',
                              hint: 'pick file ',
                              suffixIcon: IconButton(
                                  onPressed: () async {
                                    await controller.uploadFile();
                                  },
                                  icon: Icon(Icons.file_upload_outlined)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Cancel'),
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Colors.red.shade400)),
                        ),
                        controller.isloading == true
                            ? CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: controller.isloading == true
                                    ? null
                                    : () {
                                        controller.submit();
                                      },
                                child: Text('Send')),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
