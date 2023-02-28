import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../routes/app_pages.dart';
import '../../../../style/app_color.dart';

import '../../../../util/images.dart';
import '../../../../util/styles.dart';
import '../../../../widgets/custom_input.dart';
import '../controller/all_branches_reports_controller.dart';

class AllBranchesReportsView extends GetView<AllBranchesReportsController> {
  @override
  Widget build(BuildContext context) {
    AllBranchesReportsController _Controller = AllBranchesReportsController();
    return Scaffold(
      backgroundColor: AppColor.greyShade200,
      appBar: AppBar(
        title: Text(
          'branches_reports'.tr,
          style: TextStyle(
            color: AppColor.secondary,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.HOME),
            icon: Icon(Icons.home),
            color: AppColor.blackColor,
          )
        ],
        leading: backButton,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: GetBuilder<AllBranchesReportsController>(
        builder: (controller) => Container(
          color: AppColor.greyShade200,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
              padding:                   EdgeInsets.only(left: 24, top: 20, right: 24, bottom: 20),

              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Image.asset(
                          Images.report_ani,
                        )),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'select_the_dates'.tr,
                              style: robotoHuge,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'from'.tr,
                            style: robotoHuge,
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
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
                                      DateTime startDate =
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
                            'to'.tr,
                            style: robotoHuge,
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
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
                                      DateTime startDate =
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
                       Row(children: [
                        Center(
                          child: Container(
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.import_export_outlined),
                              label: Text("generate".tr),
                            ),
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 40,
                          ),
                        )
                      ])
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
