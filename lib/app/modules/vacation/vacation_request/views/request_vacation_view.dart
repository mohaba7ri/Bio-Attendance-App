import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presence/app/util/styles.dart';
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
          'Request_Vacation'.tr,
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
                              style: TextStyle(fontSize: 20),
                            ),
                            Spacer(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: DropdownButton2(
                                isExpanded: true,
                                dropdownWidth:
                                    MediaQuery.of(context).size.width * 0.45,
                                buttonWidth:
                                    MediaQuery.of(context).size.width * 0.45,
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
                              'Start_date'.tr,
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
                              'End_date'.tr,
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
                              'Days '.tr,
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
                              'File '.tr,
                              style: TextStyle(fontSize: 20),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
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
    );
  }
}
