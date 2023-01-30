import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presence/app/widgets/custom_input.dart';

import '../../../../style/app_color.dart';
import '../controllers/request_vacation_controller.dart';

class RequestVacationView extends GetView<VacationRequestController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(
          'Request Vacation',
          style: TextStyle(
            color: AppColor.secondary,
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: AppColor.secondaryExtraSoft,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
          ),
          child: Padding(
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
                            Text(
                              'Leave type',
                              style: TextStyle(fontSize: 20),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton(
                                elevation: 20,
                                value: controller.leaveTypeValue.value,
                                items: controller.vacationTypeList,
                                onChanged: (String? selectedValue) {
                                  controller.leaveTypeValue.value =
                                      selectedValue!;
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Start date',
                              style: TextStyle(fontSize: 20),
                            ),
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
                                  controller:
                                      controller.startDateController.value,
                                  label: '',
                                  hint: 'pick start date',
                                  suffixIcon: IconButton(
                                      onPressed: () async {
                                        DateTime startDate =
                                            await controller.showDatePickers(
                                                context,
                                                controller.startDateController
                                                    .value.text);
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
                            Text(
                              'End date',
                              style: TextStyle(fontSize: 20),
                            ),
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
                                  controller:
                                      controller.endDateController.value,
                                  label: '',
                                  hint: 'pick End date',
                                  suffixIcon: IconButton(
                                      onPressed: () async {
                                        DateTime startDate =
                                            await controller.showDatePickers(
                                                context,
                                                controller.endDateController
                                                    .value.text);
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
                            Text(
                              'Days ',
                              style: TextStyle(fontSize: 20),
                            ),
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
                            Text(
                              'File ',
                              style: TextStyle(fontSize: 20),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: CustomInput(
                                  valdate: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Pick File';
                                    }
                                    return null;
                                  },
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
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red.shade400,
                                  fixedSize: const Size(90, 60),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: Text(
                                'Cancel',
                                style: TextStyle(fontSize: 15),
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
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: const Size(90, 60),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15))),
                                    child: Text(
                                      'Send',
                                      style: TextStyle(fontSize: 20),
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
    );
  }
}
