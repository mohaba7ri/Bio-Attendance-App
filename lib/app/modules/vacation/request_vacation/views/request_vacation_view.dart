import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presence/app/modules/vacation/request_vacation/views/widgets/vacation_appbar.dart';

import '../../../../util/styles.dart';
import '../../../../widgets/custom_input.dart';
import '../controllers/request_vacation_controller.dart';

class RequestVacationView extends GetView<VacationRequestController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: RequestVacationAppBar(),
      body: Stack(children: [
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.7,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(15), right: Radius.circular(15)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 50),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
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
                              Text(
                                'Leave_type'.tr,
                                style: robotoHuge,
                              ),
                              Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: GetBuilder<VacationRequestController>(
                                  builder: (_controller) => DropdownButton2(
                                    hint: Text('Please Select'),
                                    items: _controller.vacationTypeList,
                                    value: _controller.leaveTypeValue,
                                    onChanged: (String? selectedValue) {
                                      _controller
                                          .changeLeaveType(selectedValue);
                                      _controller.leaveTypeValue =
                                          selectedValue;
                                      print(_controller.leaveTypeValue);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'start_date'.tr,
                                style: robotoHuge,
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: CustomInput(
                                    disabled: true,
                                    valdate: (value) {
                                      if (value!.isEmpty) {
                                        return 'please_start_date'.tr;
                                      }
                                      return null;
                                    },
                                    controller:
                                        controller.startDateController.value,
                                    label: '',
                                    hint: '',
                                    suffixIcon: IconButton(
                                        onPressed: () async {
                                          DateTime? startDate =
                                              await controller.showDatePickers(
                                                  context,
                                                  controller.startDateController
                                                      .value.text);
                                          if (startDate != null) {
                                            controller
                                                    .startDateController.value =
                                                TextEditingController(
                                                    text: DateFormat.yMMMd()
                                                        .format(startDate));
                                          } else {
                                            controller.startDateController.value
                                                .text = '';
                                          }
                                        },
                                        icon: Icon(Icons.date_range)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'end_date'.tr,
                                style: robotoHuge,
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: CustomInput(
                                    disabled: true,
                                    valdate: (value) {
                                      if (value!.isEmpty) {
                                        return 'please_pick_end_date'.tr;
                                      }
                                      return null;
                                    },
                                    controller:
                                        controller.endDateController.value,
                                    label: '',
                                    hint: '',
                                    suffixIcon: IconButton(
                                        onPressed: () async {
                                          DateTime? startDate =
                                              await controller.showDatePickers(
                                                  context,
                                                  controller.endDateController
                                                      .value.text);
                                          if (startDate != null) {
                                            controller.endDateController.value =
                                                TextEditingController(
                                                    text: DateFormat.yMMMd()
                                                        .format(startDate));
                                            controller.calculateDays();
                                          } else {
                                            controller.endDateController.value
                                                .text = '';
                                          }
                                        },
                                        icon: Icon(Icons.date_range)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Days'.tr,
                                style: robotoHuge,
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
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
                              Text(
                                'File'.tr,
                                style: robotoHuge,
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: CustomInput(
                                    // valdate: (value) {
                                    //   if (value!.isEmpty) {
                                    //     return 'Please Pick File';
                                    //   }
                                    //   return null;
                                    // },
                                    disabled: true,
                                    controller: controller.fileController.value,
                                    label: '',
                                    hint: 'pick_file'.tr,
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
                                onPressed: () {
                                  controller.getAdminData();
                                },
                                style: redElevatedButStyle,
                                child: Text(
                                  'Cancel'.tr,
                                  style: robotoMedium,
                                ),
                              ),
                              controller.isloading == true
                                  ? CircularProgressIndicator()
                                  : ElevatedButton(
                                      onPressed: controller.isloading == true
                                          ? null
                                          : () {
                                              controller.submit();
                                            },
                                      style: elevatedButStyle,
                                      child: Text(
                                        'Send'.tr,
                                        style: robotoMedium,
                                      ),
                                    ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
