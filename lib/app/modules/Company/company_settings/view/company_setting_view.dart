import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/modules/Company/company_settings/controller/company_seting_controlleer.dart';
import 'package:presence/app/style/app_color.dart';
import 'package:presence/app/widgets/custom_input.dart';

class CompanySettingView extends GetView<CompanySettingController> {
  late String? companyId;

  CompanySettingView({this.companyId});
  @override
  Widget build(BuildContext context) {
    // controller.companyId!.value=companyId;
    // TODO: implement build
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Dialog(
          child: Obx(
            () => SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
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
                    "company_setting".tr,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff008BC5)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: CustomInput(
                        disabled: true,
                        controller: TextEditingController(
                            text: controller.startTime.value.format(context)),
                        label: 'Start_Time'.tr,
                        hint: '8:00',
                        suffixIcon: IconButton(
                            onPressed: () async {
                              final initialTime = controller.startTime.value;
                              final selectedTime = await controller
                                  .showTimePickers(context, initialTime);
                              controller.setStartTime(selectedTime);
                            },
                            icon: Icon(Icons.access_time))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: CustomInput(
                        disabled: true,
                        controller: TextEditingController(
                            text: controller.lateTime.value.format(context)),
                        label: 'Late_Time'.tr,
                        hint: '8:30',
                        suffixIcon: IconButton(
                            onPressed: () async {
                              final initialTime = controller.startTime.value;
                              final selectedTime = await controller
                                  .showTimePickers(context, initialTime);
                              controller.lateTime(selectedTime);
                            },
                            icon: Icon(Icons.access_time))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: CustomInput(
                        disabled: true,
                        controller: TextEditingController(
                            text: controller.endTime.value.format(context)),
                        label: 'End_Time'.tr,
                        hint: '2:00',
                        suffixIcon: IconButton(
                            onPressed: () async {
                              final initialTime = controller.startTime.value;
                              final selectedTime = await controller
                                  .showTimePickers(context, initialTime);
                              controller.endTime(selectedTime);
                            },
                            icon: Icon(Icons.access_time))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: CustomInput(
                        disabled: true,
                        controller: TextEditingController(
                            text: controller.overlyTime.value.format(context)),
                        label: 'Overly_Time'.tr,
                        hint: '2:30',
                        suffixIcon: IconButton(
                            onPressed: () async {
                              final initialTime = controller.startTime.value;
                              final selectedTime = await controller
                                  .showTimePickers(context, initialTime);
                              controller.overlyTime(selectedTime);
                            },
                            icon: Icon(Icons.access_time))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: CustomInput(
                      keyboardType: TextInputType.number,
                      controller: controller.workingDays,
                      label: 'working_days_number'.tr,
                      hint: '',
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.50,
                    child: MaterialButton(
                      color: Colors.blueAccent.shade400,
                      onPressed: () {
                        controller.storeCompanySetting();
                        Get.back();
                      },
                      child: controller.isExistSetting.value == true
                          ? Text('Update'.tr)
                          : Text(
                              'Save'.tr,
                              style: TextStyle(
                                  color: AppColor.whiteColor, fontSize: 16),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
