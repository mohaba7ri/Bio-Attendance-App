import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/pdf_controller.dart';
import '../../../../helper/date_converter.dart';
import '../../../../routes/app_pages.dart';
import '../../../../style/app_color.dart';

import '../../../../util/styles.dart';
import '../../../../widgets/custom_input.dart';
import '../../branchReports/view/pdf_branch_reports.dart';
import '../controller/emp_reports_controller.dart';

class EmpReportsView extends GetView<EmpReportsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.greyShade200,
      appBar: AppBar(
        title: Text(
          'emp_reports'.tr,
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
      body: GetBuilder<EmpReportsController>(
        builder: (_controller) => Container(
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
              padding:
                  EdgeInsets.only(left: 24, top: 20, right: 24, bottom: 20),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'name'.tr,
                              style: robotoHuge,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.8),
                            child: SizedBox(
                              child: Text(
                                controller.user['name'],
                                style: robotoHuge,
                              ),
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
                                controller: controller.startDateController,
                                label: '',
                                hint: '',
                                suffixIcon: IconButton(
                                    onPressed: () async {
                                      DateTime startDate =
                                          await controller.showDatePickers(
                                              context,
                                              controller
                                                  .startDateController.text);
                                      if (startDate != null) {
                                        controller.changeStartDate(startDate);
                                        // controller.start = startDate;
                                      } else {
                                        controller.startDateController.text =
                                            '';
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
                                controller: controller.endDateController,
                                label: '',
                                hint: '',
                                suffixIcon: IconButton(
                                    onPressed: () async {
                                      DateTime endDate =
                                          await controller.showDatePickers(
                                              context,
                                              controller
                                                  .endDateController.text);
                                      if (endDate != null) {
                                        controller.changeEndDate(endDate);

                                        print('the endDate${controller.end}');
                                      } else {
                                        controller.startDateController.text =
                                            '';
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
                              onPressed: () async {
                                await controller.getAllPresence();
                                await controller.getData();

                                final pdfEmpReport = PdfEmpReport(
                                    start: controller.start,
                                    allPrecens: controller.allPrecens,
                                    end: controller.end);
                                final date =
                                    DateConverter.estimatedDate(DateTime.now());
                                final dueDate = DateTime.now();

                               

                                final pdfFile = await pdfEmpReport.generate();

                                PdfController.openFile(pdfFile);
                              },
                              icon: Icon(Icons.import_export_outlined),
                              label: Text("generate".tr),
                            ),
                            width: MediaQuery.of(context).size.width * 0.6,
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
